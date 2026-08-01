extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("intro")
	animated_sprite_2d.play("Walk")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		animated_sprite_2d.play("Idle")
		start_quickdraw()

func start_quickdraw():
	pass
