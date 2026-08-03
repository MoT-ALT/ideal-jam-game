extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var boss: CharacterBody2D = $Boss
@onready var dialog_player: DialogPlayer = $DialogPlayer

@export var padding = 60
var can_restart : bool

const COYOTE_WIN_DIALOG = preload("res://dialogs/coyote_win_dialog.tres")

func _ready() -> void:
	player.min_x = 0 + padding
	player.max_y = get_viewport_rect().size.y - padding
	player.min_y = 275 + padding
	player.max_x = get_viewport_rect().size.x - padding
	
	
	player.can_move = true
	player.can_shoot = false

	boss.boss_init.connect(_play_intro_dialog)
	boss.boss_died.connect(_play_outro_dialog)
	player.died.connect(_on_player_died)

func _process(delta: float) -> void:
	if can_restart:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()


func _on_player_died() -> void:
	boss.set_physics_process(false)
	player.can_move = false
	player.can_shoot = false
	dialog_player._dialog_data = COYOTE_WIN_DIALOG
	dialog_player.start() # starts the coyote_win_dialog
	await dialog_player.dialog_ended
	$GamerOver.show()
	can_restart = true


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
	await dialog_player.dialog_ended
	#SceneTransitionManager.load_scene("") # Credict Scene
