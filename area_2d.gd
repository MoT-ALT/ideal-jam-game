extends Area2D


@export var mouseSpeed: float = 3.0
var is_active: bool = false
var bullets : int = 6

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	reset_position()
	%CursorState.play("default")

func reset_position() -> void:
	var viewport_size := get_viewport_rect().size
	global_position = Vector2(viewport_size.x / 2.0, viewport_size.y)

func start_aiming() -> void:
	is_active = true

func stop_aiming() -> void:
	is_active = false

func _process(delta: float) -> void:
	if not is_active:
		return
	global_position = global_position.lerp(get_global_mouse_position(), mouseSpeed * delta)

	if Input.is_action_just_pressed("shoot"):
		%CursorState.play("shoot")
		bullets -=1
	else:
		%CursorState.play("default")
	match bullets:
		6:
			%ammo.play("6")
		5:
			%ammo.play("5")
		4:
			%ammo.play("4")
		3:
			%ammo.play("3")
		2: 
			%ammo.play("2")
		1:
			%ammo.play("1")
		0:
			%ammo.play("0")



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event.is_action_pressed("shoot"):
		for area in get_overlapping_areas():
			if area.has_method("take_damage"):
				area.take_damage()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN and not Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)



func _on_dual_start_timeout() -> void:
	start_aiming()
	%dualTimer.start()


func _on_dual_timer_timeout() -> void:
	reset_position()

	stop_aiming()
