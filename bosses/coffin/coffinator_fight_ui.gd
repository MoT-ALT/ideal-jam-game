extends Node2D

@export var mouseSpeed: float = 3.0
var is_active: bool = false
var bullets: int = 6
signal round_won
signal round_lost

var game_ended: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	reset_position()
	%CursorState.play("default")
	start_round()

func start_round() -> void:
	bullets = 6
	%dualStart/Label.text = str(ceil(%dualStart.wait_time))
	%dualStart.start()

func reset_position() -> void:
	var viewport_size := get_viewport_rect().size
	%Cursor.global_position = Vector2(viewport_size.x / 2.0, viewport_size.y)

func start_aiming() -> void:
	is_active = true

func stop_aiming() -> void:
	is_active = false

func _process(delta: float) -> void:
	if not %dualStart.is_stopped():
		%dualStart/Label.text = str(ceil(%dualStart.time_left))

	if not %dualTimer.is_stopped():
		%dualTimer/Label.text = str(ceil(%dualTimer.time_left))

	if not is_active:
		return

	%Cursor.global_position = %Cursor.global_position.lerp(get_global_mouse_position(), mouseSpeed * delta)
	if Input.is_action_just_pressed("shoot"):
		%CursorState.play("shoot")
		bullets = max(bullets - 1, 0)
	else:
		%CursorState.play("default")
	match bullets:
		6: %ammo.play("6")
		5: %ammo.play("5")
		4: %ammo.play("4")
		3: %ammo.play("3")
		2: %ammo.play("2")
		1: %ammo.play("1")
		0: 
			%ammo.play("0")
			_trigger_game_over()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		stop_aiming()
	if event.is_action_pressed("shoot"):
		for area in %Cursor.get_overlapping_areas():
			if area.has_method("take_damage"):
				area.take_damage()
				if "health" in area and area.health <= 0:
					_trigger_game_won()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN and not Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _trigger_game_won() -> void:
	if game_ended:
		return
	game_ended = true
	stop_aiming()
	%dualTimer.stop()
	%dualTimer/Label.text = "You Win!"
	if not Global.Bosses_Beaten.has("coffinator"):
		Global.Bosses_Beaten.append("coffinator")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	round_won.emit()

func _trigger_game_over() -> void:
	if game_ended:
		return
	game_ended = true
	stop_aiming()
	%dualTimer.stop()
	%dualTimer/Label.text = "You Lost!"
	await get_tree().create_timer(0.7).timeout
	$GameOverScreen.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	round_lost.emit()


func _on_dual_start_timeout() -> void:
	%dualStart/Label.text = "DUAL!"
	await get_tree().create_timer(0.5).timeout
	%dualStart/Label.hide()
	start_aiming()
	%dualTimer.start()
	

func _on_dual_timer_timeout() -> void:
	%dualTimer/Label.text = "You Lost!"
	reset_position()
	stop_aiming()
	_trigger_game_over()
