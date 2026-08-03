extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func fade_in_out() -> void:
	modulate.a = 0.0
	visible = true

	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	tween.tween_interval(4)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)

	await tween.finished
	visible = false
