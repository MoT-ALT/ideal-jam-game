extends Area2D

const SPEED := 600.0
const LIFETIME := 3.0

var direction := Vector2.RIGHT
var ignore: Node2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(LIFETIME).timeout
	if is_inside_tree():
		queue_free()


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body == ignore:
		return
	queue_free()
