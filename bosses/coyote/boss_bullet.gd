extends Area2D

const SPEED := 275.0
const LIFETIME := 3.5

var direction := Vector2.DOWN
var target: Node2D


func _ready() -> void:
	add_to_group("boss_bullets")
	area_entered.connect(_on_area_entered)
	await get_tree().create_timer(LIFETIME).timeout
	if is_inside_tree():
		queue_free()


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var to_target := target.global_position - global_position
		if to_target.length_squared() > 0.0:
			direction = to_target.normalized()
	position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hitbox") and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage()
	queue_free()
