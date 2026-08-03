extends CharacterBody2D

const SPEED := 150.0
const X_RADIUS := 150.0
const X_DEADZONE := 5.0
const SHOT_COOLDOWN := 2.0
const HIT_TIME := 0.3
const BOSS_BULLET_SCENE := preload("res://bosses/coyote/BossBullet.tscn")

var started: bool
var is_shooting: bool
var is_hit := false
var hit_time_left := 0.0
var shoot_cooldown: float
var orbs_remaining := 0
var volley_fired := false

signal boss_init
signal boss_died

@onready var player := get_node("../Player") as CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_player: DialogPlayer = $"../DialogPlayer"
const COYOTE_OUTRO = preload("res://dialogs/coyote_lose_dialog.tres")


func _ready() -> void:
	orbs_remaining = get_tree().get_nodes_in_group("Orb").size()
	animation_player.play("intro")
	animated_sprite_2d.play("Walk")
	animated_sprite_2d.animation_finished.connect(_on_animated_sprite_finished)


func _physics_process(delta: float) -> void:
	if not started:
		return

	hit_time_left = maxf(hit_time_left - delta, 0.0)
	if is_hit:
		velocity = Vector2.ZERO
		if hit_time_left <= 0.0:
			is_hit = false
		return

	position.x = wrapf(position.x, 0.0, 1156.0)
	shoot_cooldown = maxf(shoot_cooldown - delta, 0.0)

	var to_player := player.global_position - global_position
	var in_range := absf(to_player.x) <= X_RADIUS

	if is_shooting:
		velocity = Vector2.ZERO
		if not volley_fired and animated_sprite_2d.frame >= animated_sprite_2d.sprite_frames.get_frame_count("Shoot") - 4:
			volley_fired = true
			fire_volley()
		return

	if in_range and shoot_cooldown == 0.0:
		start_shoot()
	elif absf(to_player.x) > X_DEADZONE:
		animated_sprite_2d.flip_h = to_player.x < 0
		velocity = Vector2(signf(to_player.x), 0) * SPEED
		play_anim("Walk")
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		play_anim("Idle")


func start_shoot() -> void:
	is_shooting = true
	volley_fired = false
	velocity = Vector2.ZERO
	AudioManager.play_shooting()
	animated_sprite_2d.play("Shoot")


func fire_volley() -> void:
	for i in 3:
		spawn_boss_bullet()
		await get_tree().create_timer(0.2).timeout


func spawn_boss_bullet() -> void:
	var bullet := BOSS_BULLET_SCENE.instantiate()
	bullet.global_position = global_position
	bullet.direction = (player.global_position - global_position).normalized()
	bullet.target = player
	get_tree().current_scene.add_child(bullet)


func play_anim(anim: StringName) -> void:
	if animated_sprite_2d.animation != anim:
		animated_sprite_2d.play(anim)


func _on_animated_sprite_finished() -> void:
	if animated_sprite_2d.animation == "Shoot":
		is_shooting = false
		shoot_cooldown = SHOT_COOLDOWN


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		emit_signal("boss_init")
		start_boss_fight()


func start_boss_fight() -> void:
	started = true


func on_orb_destroyed(_orb: Area2D) -> void:
	is_shooting = false
	AudioManager.play_hit()
	Juice.shake(get_viewport().get_camera_2d(),0.75,1.5,Vector2(24,16),0.12)
	animated_sprite_2d.play("Hit")
	is_hit = true
	hit_time_left = HIT_TIME
	orbs_remaining -= 1
	if orbs_remaining <= 0:
		die()


func die() -> void:
	emit_signal("boss_died")
	set_physics_process(false)
	dialog_player._dialog_data = COYOTE_OUTRO # start the coyote lose dialog
	dialog_player.start()
	
