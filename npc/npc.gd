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
@export var dialogs: Array = []

@export_group("Interaction")
@export var trigger_mode: TriggerMode = TriggerMode.MANUAL
@export var interact_action: StringName = &"interact"
@export var freeze_player: bool = true
@export var flip_sprite: Sprite2D
@export var prompt_label: Label

@export_group("Sprite")
@export var sprite_frame: int = 0
@export var hide_default_sprite: bool = false

var player: Node2D
var can_interact: bool = false
var dialog_running: bool = false

var _played_stages: Array[NPCDialogStage] = []
var _npc_key: String
var _saved_movement: Dictionary = { "can_move": true, "can_shoot": false }
var _known_boss_count := -1
var _fallback_stage: NPCDialogStage
var _fallback_stage_data: SproutyDialogsDialogueData
var _fallback_stage_id: String
var _dialog_box_refs: Array[PackedScene] = []

@onready var interaction_area: Area2D = $InteractionArea
@onready var dialog_player: DialogPlayer = $DialogPlayer
@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	sprite.frame = sprite_frame
	if hide_default_sprite:
		sprite.visible = false
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	if prompt_label:
		prompt_label.visible = false
	_known_boss_count = Global.Bosses_Beaten.size()
	_npc_key = _build_npc_key()
	_restore_played_stages()
	_keep_all_stage_dialog_boxes()
	_preload_dialog()


func _process(_delta: float) -> void:
	var count := Global.Bosses_Beaten.size()
	if count != _known_boss_count:
		_known_boss_count = count
		_preload_dialog()
		_update_interaction_state()


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
	var stage := _active_stage()
	if stage == null:
		return
	if dialog_player.get_dialog_data() != stage.dialog_data \
			or dialog_player.get_start_id() != stage.start_id:
		_apply_stage(stage)
	_played_stages.append(stage)
	Global.mark_npc_stage_played(_npc_key, stage.resource_path)
	dialog_running = true
	_freeze(true)
	_set_prompt_visible(false)
	dialog_started.emit()
	dialog_player.start()
	await dialog_player.dialog_ended
	dialog_running = false
	_freeze(false)
	_update_interaction_state()
	dialog_finished.emit()


func _stage_list() -> Array[NPCDialogStage]:
	if not dialogs.is_empty():
		var result: Array[NPCDialogStage] = []
		for item in dialogs:
			if item is NPCDialogStage:
				result.append(item)
		return result
	if dialog_data != null:
		return [_fallback_stage_get()]
	return []


func _fallback_stage_get() -> NPCDialogStage:
	if _fallback_stage == null or _fallback_stage_data != dialog_data \
			or _fallback_stage_id != start_id:
		_fallback_stage = NPCDialogStage.new()
		_fallback_stage.dialog_data = dialog_data
		_fallback_stage.start_id = start_id
		_fallback_stage.one_shot = false
		_fallback_stage_data = dialog_data
		_fallback_stage_id = start_id
	return _fallback_stage


func _active_stage() -> NPCDialogStage:
	for stage in _stage_list():
		if _stage_condition_passes(stage) \
				and (not stage.one_shot or not _played_stages.has(stage)):
			return stage
	return null


func _stage_condition_passes(stage: NPCDialogStage) -> bool:
	match stage.condition:
		NPCDialogStage.Condition.BOSS_DEFEATED:
			return Global.Bosses_Beaten.has(stage.boss_key)
		NPCDialogStage.Condition.BOSS_NOT_DEFEATED:
			return not Global.Bosses_Beaten.has(stage.boss_key)
		_:
			return true


func _build_npc_key() -> String:
	var owner_scene := ""
	if owner and owner.get_scene_file_path() != "":
		owner_scene = owner.get_scene_file_path()
	else:
		owner_scene = get_scene_file_path()
	return Global.get_npc_key(owner_scene, name)


func _restore_played_stages() -> void:
	_played_stages.clear()
	for stage in _stage_list():
		if Global.is_npc_stage_played(_npc_key, stage.resource_path):
			_played_stages.append(stage)


func _can_start_dialog() -> bool:
	return can_interact and not dialog_running and _active_stage() != null


func _preload_dialog() -> void:
	var stage := _active_stage()
	if stage == null:
		return
	if dialog_player.get_dialog_data() == stage.dialog_data \
			and dialog_player.get_start_id() == stage.start_id:
		return
	_apply_stage(stage)


func _apply_stage(stage: NPCDialogStage) -> void:
	_keep_dialog_box_refs(stage)
	dialog_player._starts_ids = stage.dialog_data.get_start_ids()
	dialog_player.set_dialog(stage.dialog_data, stage.start_id)


func _keep_all_stage_dialog_boxes() -> void:
	for stage in _stage_list():
		_keep_dialog_box_refs(stage)


func _keep_dialog_box_refs(stage: NPCDialogStage) -> void:
	for sid in stage.dialog_data.get_start_ids():
		if not stage.dialog_data.characters.has(sid):
			continue
		for char_uid in stage.dialog_data.characters[sid].values():
			if not ResourceUID.has_id(char_uid):
				continue
			var char_data: SproutyDialogsCharacterData = load(ResourceUID.get_id_path(char_uid))
			if char_data == null or char_data.dialog_box_uid == -1:
				continue
			if not ResourceUID.has_id(char_data.dialog_box_uid):
				continue
			var box_path := ResourceUID.get_id_path(char_data.dialog_box_uid)
			var already_held := false
			for held in _dialog_box_refs:
				if held.resource_path == box_path:
					already_held = true
					break
			if not already_held:
				_dialog_box_refs.append(load(box_path))


func _update_interaction_state() -> void:
	can_interact = is_instance_valid(player) and _active_stage() != null
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


func _set_prompt_visible(_visible: bool) -> void:
	if prompt_label:
		prompt_label.visible = _visible
