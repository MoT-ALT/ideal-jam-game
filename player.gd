extends CharacterBody2D

const SPEED = 300.0
const SHOOT_DURATION := 0.6

@onready var animation_tree := $AnimationTree as AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

var last_direction := Vector2.DOWN
var is_shooting := false


func _ready() -> void:
	animation_tree.active = true


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction and not is_shooting:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO

	var blend := direction if direction else last_direction
	animation_tree["parameters/Idle/blend_position"] = blend
	animation_tree["parameters/Walk/blend_position"] = blend
	animation_tree["parameters/Shoot/blend_position"] = blend

	if is_shooting:
		pass
	elif Input.is_action_just_pressed("shoot"):
		shoot()
	elif direction:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
		

	move_and_slide()


func shoot() -> void:
	is_shooting = true
	state_machine.travel("Shoot")
	await get_tree().create_timer(SHOOT_DURATION).timeout
	is_shooting = false
