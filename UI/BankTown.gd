extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var cactus_npc: NPC = $CactusNPC

func _ready() -> void:
	SceneTransitionManager.init_scene()
	player.min_y = 0
	player.min_x = 0
	
	player.max_y = 1130
	player.max_x = 2400
	cactus_npc.dialog_finished.connect(_on_cactus_npc_dialog_finished)


func _on_cactus_npc_dialog_finished() -> void:
	SceneTransitionManager.load_scene("res://bosses/cow_cactus/cow_cactus.tscn")
