extends Area2D

const SPEED := 275.0
const LIFETIME := 4.0

var direction := Vector2.DOWN
var target: Node2D
var shooter: Node2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(LIFETIME).timeout
	if is_inside_tree():
		queue_free()


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var to_target := target.global_position - global_position
		if to_target.length_squared() > 0.0:
			direction = to_target.normalized()
	position += direction * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body == shooter:
		return
	if body == target and target.has_method("take_damage"):
		target.take_damage()
	queue_free()
