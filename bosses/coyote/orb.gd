extends Area2D

@export var health := 5

@onready var crack: Sprite2D = $Crack


func take_damage() -> void:
	health -= 1
	Juice.damage_number(self, global_position+Vector2(0,-10), 1)
	crack.frame += 1
	if health <= 0:
		var boss := get_node("../../Boss")
		if boss and boss.has_method("on_orb_destroyed"):
			boss.on_orb_destroyed(self)
		queue_free()
