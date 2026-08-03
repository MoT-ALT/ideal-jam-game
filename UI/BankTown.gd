extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	player.min_y = 0
	player.min_x = 0
	
	player.max_y = 1130
	player.max_x = 2400
