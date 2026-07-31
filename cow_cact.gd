extends Area2D
@export var dualTimer: Timer
var health : int 
@onready var cursor: Node2D = $"."
var maxHealth : int = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%cowCactAnimation.play("IDLE")
	%heart1.play("default")
	%heart2.play("default")
	health = maxHealth

func take_damage():
	health -= 1
	print("dameged")
	match health:
		1:
			%heart2.hide()
		0:
			%heart1.hide()
			%cowCactAnimation.play("DEAD")
func _on_duel_timer_ended() -> void:
	print("timer finished!")
	if health > 0 and dualTimer.time_left <= 0 :
		%cowCactAnimation.play("SHOOT")
func _process(delta: float) -> void:
	pass
