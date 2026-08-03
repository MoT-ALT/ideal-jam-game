extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var grave_npc: NPC = $GraveNPC
@onready var grave_npc_sprite: Sprite2D = $GraveNPC/Sprite
@onready var coyote_reveal_sprite: Sprite2D = $GraveNPC/CoyoteReveal
@onready var prompt_label: Label = $CanvasLayer/Label

var player_is_in_cow_cactus_area : bool
var player_is_in_coffinator_area : bool
var coyote_revealed := false

func _ready() -> void:
	SceneTransitionManager.init_scene()
	player.min_x = 0 
	player.max_y = 1460
	player.min_y = 0 
	player.max_x = 2448
	grave_npc.dialog_finished.connect(_on_grave_npc_dialog_finished)


func _process(delta: float) -> void:
	
	if player_is_in_cow_cactus_area or (player_is_in_coffinator_area and Global.Bosses_Beaten.has("cow_cactus")):
		prompt_label.show()
	else: 
		prompt_label.hide()
	
	if Input.is_action_pressed("interact") and player_is_in_cow_cactus_area:
		if Global.Bosses_Beaten.has("cow_cactus"):
			Juice.shake(get_viewport().get_camera_2d())
		else :
			SceneTransitionManager.load_scene("res://UI/i2.tscn")
	
	if Input.is_action_pressed("interact") and player_is_in_coffinator_area and Global.Bosses_Beaten.has("cow_cactus"):
		if Global.Bosses_Beaten.has("coffinator"):
			Juice.shake(get_viewport().get_camera_2d())
		else :
			SceneTransitionManager.load_scene("res://scenes/test_fight.tscn")

func _on_cow_cactus_body_entered(body: Node2D) -> void: 
	if body.is_in_group("Player"):
		player_is_in_cow_cactus_area = true


func _on_cow_cactus_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_in_cow_cactus_area = false


func _on_coffinator_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_in_coffinator_area = true


func _on_coffinator_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_in_coffinator_area = false


func _on_grave_npc_dialog_finished() -> void:
	if coyote_revealed or not Global.is_grave_digger_coyote:
		return
	coyote_revealed = true
	grave_npc.can_interact = false
	_reveal_coyote()


func _reveal_coyote() -> void:
	grave_npc_sprite.modulate.a = 1.0
	coyote_reveal_sprite.visible = true
	coyote_reveal_sprite.modulate.a = 0.0
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(grave_npc_sprite, "modulate:a", 0.0, 0.6)
	tween.tween_property(coyote_reveal_sprite, "modulate:a", 1.0, 0.6)
	await tween.finished
	await get_tree().create_timer(0.8).timeout
	SceneTransitionManager.load_scene("res://bosses/coyote/Coyote.tscn")
