extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var boss = get_node("../Boss")

var duel_active := false


func _ready() -> void:
	animation_player.play("intro")
	animated_sprite_2d.play("Walk")


func _process(_delta: float) -> void:
	if duel_active and Input.is_action_just_pressed("shoot"):
		boss.player_draw()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		animated_sprite_2d.play("Idle")
		start_quickdraw()


func start_quickdraw() -> void:
	duel_active = true
	animated_sprite_2d.play("Idle")


func reset_duel() -> void:
	duel_active = true
	animated_sprite_2d.play("Idle")


func fire() -> void:
	animated_sprite_2d.play("Shoot")
	await get_tree().create_timer(5).timeout
	if is_inside_tree():
		animated_sprite_2d.play("Idle")


func play_death() -> void:
	duel_active = false
	Juice.damage_number(self, global_position+Vector2(0,-60), 10000)
	animated_sprite_2d.play("Death")
