extends Button

func _ready() -> void:
	_update_text()
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	LangManager.toggle()
	_update_text()

func _update_text() -> void:
	text = "LANGUAGE: " + LangManager.current_locale.to_upper()
