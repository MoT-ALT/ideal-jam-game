extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var boss: CharacterBody2D = $Boss
@onready var dialog_player: DialogPlayer = $DialogPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_move = true
	player.can_shoot = false

	boss.boss_init.connect(_play_intro_dialog)
	boss.boss_died.connect(_play_outro_dialog)


func _play_intro_dialog() -> void:
	dialog_player.start()
	boss.set_physics_process(false)
	player.set_physics_process(false)
	await dialog_player.dialog_ended
	player.can_move = true
	player.can_shoot = true
	player.set_physics_process(true)
	boss.set_physics_process(true)
	

func _play_outro_dialog():
	player.can_shoot = false
	player.can_move = false
