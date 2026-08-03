extends CharacterBody2D

signal died

const SPEED = 300.0
const SHOOT_DURATION := 0.6
const MAX_HEALTH := 100
const HIT_DURATION := 0.1
const BULLET_SCENE := preload("res://player/Bullet.tscn")

@onready var animation_tree := $AnimationTree as AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

var last_direction := Vector2.DOWN
var is_shooting := false
var can_shoot := false
var can_move := true
var is_dead := false
var hit_active := false

var min_x: int
var min_y: int
var max_x: int
var max_y: int

var health: int = MAX_HEALTH


func _ready() -> void:
	animation_tree.active = true


func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return

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
	elif hit_active:
		pass
	elif can_shoot and Input.is_action_just_pressed("shoot"):
		shoot()
	elif direction and can_move:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

	move_and_slide()
	global_position.x = clampf(global_position.x, min_x, max_x)
	global_position.y = clampf(global_position.y, min_y, max_y)


func shoot() -> void:
	is_shooting = true
	AudioManager.play_shooting()
	state_machine.travel("Shoot")
	var bullet := BULLET_SCENE.instantiate()
	bullet.global_position = $Muzzle.global_position
	bullet.direction = last_direction
	bullet.ignore = self
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(SHOOT_DURATION).timeout
	is_shooting = false


func take_damage(amount: int = 20) -> void:
	if is_dead:
		return
	health -= amount
	AudioManager.play_hit()
	Juice.damage_number(self, global_position+Vector2(0,-60), amount)
	Juice.shake(get_viewport().get_camera_2d())
	if health <= 0:
		health = 0
		die()
		return
	if not hit_active:
		hit_active = true
		state_machine.travel("Hit")
		await get_tree().create_timer(HIT_DURATION).timeout
		hit_active = false
		if not is_dead:
			state_machine.travel("Idle")


func die() -> void:
	if is_dead:
		return
	is_dead = true
	can_move = false
	can_shoot = false
	hit_active = false
	velocity = Vector2.ZERO
	state_machine.travel("Death")
	died.emit()
