extends Area2D

signal game_won
signal game_over
@export var move_speed: float = 220.0
@export var horizontal_move_speed: float = 220.0
@export var edge_margin: float = 26.0

var health: int
var maxHealth: int = 3
var current_state: String = "IDLE"
var move_direction: Vector2 = Vector2.ZERO

var action_timer: Timer

var hittable_states: Array[String] = ["IDLE", "MOVE_DOWN", "MOVE_UP", "MOVE_RIGHT_LEFT"]

func _ready() -> void:
	%sand.hide()
	randomize()
	%coffinatorAnimation.play("IDLE")
	%heart1.play("default")
	%heart2.play("default")
	%heart3.play("default")
	health = maxHealth

	action_timer = Timer.new()
	add_child(action_timer)
	action_timer.one_shot = true
	action_timer.timeout.connect(_on_action_timer_timeout)
	_pick_new_action()

func _pick_new_action() -> void:
	%coffinatorAnimation.scale.y = 1.0
	%coffinatorAnimation.modulate.a = 1.0

	var states := [
		"IDLE",
		"MOVE_DOWN",
		"MOVE_UP",
		"MOVE_RIGHT_LEFT",
		"UNDERGROUND"
	]

	current_state = states[randi() % states.size()]

	if current_state != "MOVE_RIGHT_LEFT":
		%coffinatorAnimation.flip_h = false

	monitorable = current_state in hittable_states

	action_timer.wait_time = randf_range(1.0, 2.5) if current_state != "UNDERGROUND" else 2.0
	action_timer.start()

	match current_state:
		"IDLE":
			move_direction = Vector2.ZERO
			%coffinatorAnimation.play("IDLE")
		"MOVE_DOWN":
			move_direction = Vector2.DOWN
			%coffinatorAnimation.play("MOVE_DOWN")
		"MOVE_UP":
			move_direction = Vector2.UP
			%coffinatorAnimation.play("MOVE_UP")
		"MOVE_RIGHT_LEFT":
			var going_left := randi() % 2 == 0
			move_direction = Vector2.LEFT if going_left else Vector2.RIGHT
			%coffinatorAnimation.play("MOVE_RIGHT_LEFT")
		"UNDERGROUND":
			move_direction = Vector2.ZERO
			%coffinatorAnimation.play("IDLE")
			_go_underground()
			%sand.play("default")
			%sand.show()
			await get_tree().create_timer(1.0).timeout
			%sand.hide()

func _go_underground() -> void:
	var tween = create_tween().set_parallel(true)

	tween.tween_property(%coffinatorAnimation, "scale:y", 0.0, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(%coffinatorAnimation, "modulate:a", 0.0, 0.8)

	tween.chain().tween_callback(func():
		var viewport_size := get_viewport_rect().size
		var random_x := randf_range(edge_margin, viewport_size.x - edge_margin)
		var random_y := randf_range(edge_margin, viewport_size.y - edge_margin)
		global_position = Vector2(random_x, random_y)
	)

	tween.chain().tween_property(%coffinatorAnimation, "scale:y", 1.0, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%coffinatorAnimation, "modulate:a", 1.0, 0.8)

func _on_action_timer_timeout() -> void:
	if health > 0:
		_pick_new_action()

func take_damage() -> void:
	if health <= 0:
		return
	health -= 1
	match health:
		2:
			%heart3.hide()
		1:
			%heart2.hide()
		0:
			%heart1.hide()
			%coffinatorAnimation.play("DEAD")
			monitorable = false
			action_timer.stop()

func _process(delta: float) -> void:
	if health <= 0:
		return

	match current_state:
		"MOVE_DOWN", "MOVE_UP":
			global_position += move_direction * move_speed * delta
		"MOVE_RIGHT_LEFT":
			global_position += move_direction * horizontal_move_speed * delta

	var viewport_size := get_viewport_rect().size

	if global_position.x <= edge_margin and move_direction.x < 0:
		move_direction.x = 1.0
	elif global_position.x >= viewport_size.x - edge_margin and move_direction.x > 0:
		move_direction.x = -1.0

	if move_direction.x != 0.0:
		%coffinatorAnimation.flip_h = move_direction.x < 0.0

	if global_position.y <= edge_margin and move_direction.y < 0:
		move_direction = Vector2.DOWN
		current_state = "MOVE_DOWN"
		monitorable = current_state in hittable_states
		%coffinatorAnimation.play("MOVE_DOWN")
	elif global_position.y >= viewport_size.y - edge_margin and move_direction.y > 0:
		move_direction = Vector2.UP
		current_state = "MOVE_UP"
		monitorable = current_state in hittable_states
		%coffinatorAnimation.play("MOVE_UP")

	global_position.x = clamp(global_position.x, edge_margin, viewport_size.x - edge_margin)
	global_position.y = clamp(global_position.y, edge_margin, viewport_size.y - edge_margin)
