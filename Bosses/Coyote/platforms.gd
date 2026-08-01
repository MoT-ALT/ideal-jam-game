extends Node2D

const SPEED := 300.0
const LIMIT := 400.0


func _process(delta: float) -> void:
	position.x += SPEED * delta
	position.x = wrapf(position.x, 0.0, LIMIT)
