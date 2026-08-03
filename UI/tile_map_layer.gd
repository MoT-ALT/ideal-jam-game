extends Node2D

@onready var player: CharacterBody2D = $Player

var player_is_in_cow_cactus_area : bool
var player_is_in_coffinator_area : bool

func _ready() -> void:
	SceneTransitionManager.init_scene()
	player.min_x = 0 
	player.max_y = 1460
	player.min_y = 0 
	player.max_x = 2448


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_3):
		print(Global.Bosses_Beaten)
	if Input.is_action_pressed("interact") and player_is_in_cow_cactus_area:
		SceneTransitionManager.load_scene("res://bosses/cow_cactus/cow_cactus.tscn")
	
	if Input.is_action_pressed("interact") and player_is_in_coffinator_area and Global.Bosses_Beaten.has("cow_cactus"):
		SceneTransitionManager.load_scene("res://scenes/test_fight.tscn")

func _on_cow_cactus_body_entered(body: Node2D) -> void: 
	player_is_in_cow_cactus_area = true


func _on_cow_cactus_body_exited(body: Node2D) -> void:
	player_is_in_cow_cactus_area = false


func _on_coffinator_body_entered(body: Node2D) -> void:
	player_is_in_coffinator_area = true


func _on_coffinator_body_exited(body: Node2D) -> void:
	player_is_in_coffinator_area = false
