class_name NPC
extends Node2D

signal player_entered(player: Node2D)
signal player_exited(player: Node2D)
signal interacted
signal dialog_started
signal dialog_finished

enum TriggerMode { MANUAL, ON_ENTER }

@export_group("Dialog")
@export var dialog_data: SproutyDialogsDialogueData
@export var start_id: String = "1"

@export_group("Interaction")
@export var trigger_mode: TriggerMode = TriggerMode.MANUAL
@export var interact_action: StringName = &"interact"
@export var freeze_player: bool = true
@export var can_repeat: bool = true
@export var flip_sprite: Sprite2D
@export var prompt_label: Label

var player: Node2D
var can_interact: bool = false
var dialog_running: bool = false

var _has_played := false
var _saved_movement: Dictionary = { "can_move": true, "can_shoot": false }

@onready var interaction_area: Area2D = $InteractionArea
@onready var dialog_player: DialogPlayer = $DialogPlayer


func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	if prompt_label:
		prompt_label.visible = false
	_preload_dialog()


func _preload_dialog() -> void:
	if dialog_data == null or start_id.is_empty():
		return
	dialog_player._starts_ids = dialog_data.get_start_ids()
	dialog_player.set_dialog(dialog_data, start_id)


func _unhandled_input(event: InputEvent) -> void:
	if trigger_mode != TriggerMode.MANUAL:
		return
	if event.is_action_pressed(interact_action) and can_interact:
		try_interact()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	player = body
	_update_interaction_state()
	player_entered.emit(player)
	if trigger_mode == TriggerMode.ON_ENTER:
		try_interact()


func _on_body_exited(body: Node2D) -> void:
	if body != player:
		return
	player = null
	can_interact = false
	player_exited.emit(body)
	_set_prompt_visible(false)


func try_interact() -> void:
	if not _can_start_dialog():
		return
	interacted.emit()
	play_dialog()


func play_dialog() -> void:
	if dialog_running:
		return
	if dialog_data == null or start_id.is_empty():
		push_warning("NPC '%s' has no dialog_data assigned" % name)
		return
	dialog_running = true
	_has_played = true
	_freeze(true)
	_set_prompt_visible(false)
	_flip_toward_player()
	dialog_started.emit()
	dialog_player.start()
	await dialog_player.dialog_ended
	dialog_running = false
	_freeze(false)
	if not can_repeat:
		player = null
		_update_interaction_state()
	dialog_finished.emit()


func _can_start_dialog() -> bool:
	return can_interact and not dialog_running and (can_repeat or not _has_played)


func _update_interaction_state() -> void:
	can_interact = is_instance_valid(player) and (can_repeat or not _has_played)
	_set_prompt_visible(can_interact)


func _freeze(frozen: bool) -> void:
	if not freeze_player or not is_instance_valid(player):
		return
	if frozen:
		_saved_movement["can_move"] = player.get("can_move")
		_saved_movement["can_shoot"] = player.get("can_shoot")
		player.set("can_move", false)
		player.set("can_shoot", false)
	else:
		player.set("can_move", _saved_movement["can_move"])
		player.set("can_shoot", _saved_movement["can_shoot"])


func _flip_toward_player() -> void:
	if not flip_sprite or not is_instance_valid(player):
		return
	flip_sprite.flip_h = player.global_position.x < global_position.x


func _set_prompt_visible(visible: bool) -> void:
	if prompt_label:
		prompt_label.visible = visible
