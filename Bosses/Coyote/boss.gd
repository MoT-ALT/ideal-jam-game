extends CharacterBody2D

const SPEED:int = 8

var started:bool
var moving:bool
var shooting:bool

signal boss_init

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("intro")
	animated_sprite_2d.play("Walk")


func _physics_process(delta: float) -> void:
	position.x = wrap(position.x,0,1156)
	if started:
		if moving:
			var dir = Vector2(5,0)
			velocity = dir * SPEED
			animated_sprite_2d.play("Walk")
			move_and_slide()
		elif shooting:
			animated_sprite_2d.play("Shoot")
			# shoot()
		else: animated_sprite_2d.play("Idle")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro" :
		emit_signal("boss_init")
		start_boss_fight()

func start_boss_fight():
	started = true
	animated_sprite_2d.play("Idle")
	
