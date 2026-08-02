extends CharacterBody2D

const SPEED = 300.0
const SHOOT_DURATION := 0.6
const BULLET_SCENE := preload("res://Bullet.tscn")

@onready var animation_tree := $AnimationTree as AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

var last_direction := Vector2.DOWN
var is_shooting := false
var can_shoot := false
var can_move := true

func _ready() -> void:
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction and not is_shooting and can_move:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO

	var blend := direction if direction else last_direction
	if !is_shooting and can_move:
		animation_tree["parameters/Idle/blend_position"] = blend
		animation_tree["parameters/Walk/blend_position"] = blend
		animation_tree["parameters/Shoot/blend_position"] = blend

	if is_shooting:
		pass
	elif can_shoot and Input.is_action_just_pressed("shoot"):
		shoot()
	elif direction and can_move :
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

	move_and_slide()

func shoot() -> void:
	is_shooting = true
	state_machine.travel("Shoot")
	var bullet := BULLET_SCENE.instantiate()
	bullet.global_position = $Muzzle.global_position
	bullet.direction = last_direction
	bullet.ignore = self
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(SHOOT_DURATION).timeout
	is_shooting = false
