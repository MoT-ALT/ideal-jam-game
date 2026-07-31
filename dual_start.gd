extends Timer

@onready var timer_label: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_label.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time_left >0 :
		var minutes: int = int(time_left) / 60
		var seconds: int = int(time_left) % 60
		timer_label.text = "%02d:%02d" % [minutes,seconds]
	else:
		timer_label.text = "DUAL!"
		await get_tree().create_timer(0.5).timeout
		timer_label.hide()
