extends SceneTransition

## Circle wipe transition driven by UI/shader/circle.gdshader.
## _Progress 0 = open (scene visible), 1 = closed (circle covers the screen).

@export var transition_time: float = 0.5

@onready var circle_rect: ColorRect = $CanvasLayer/CircleRect

var tween: Tween = null


func _ready() -> void:
	hide()


func _set_progress(value: float) -> void:
	var material: ShaderMaterial = circle_rect.material
	material.set_shader_parameter("_Progress", value)


func _tween_progress(from: float, to: float, duration: float) -> Tween:
	var t := create_tween()
	_set_progress(from)
	t.tween_method(_set_progress, from, to, duration)
	return t


func play_out(callback: Callable = Callable()) -> void:
	show()
	if tween:
		tween.kill()
	tween = _tween_progress(0.0, 1.0, transition_time)
	if callback.is_valid():
		tween.finished.connect(callback)


func play_in(callback: Callable = Callable()) -> void:
	if tween:
		tween.kill()
	tween = _tween_progress(1.0, 0.0, transition_time)
	tween.finished.connect(
		func() -> void:
			if callback.is_valid():
				callback.call()
			hide()
			queue_free()
	)
