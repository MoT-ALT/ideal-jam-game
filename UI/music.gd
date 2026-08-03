extends Button

func _ready() -> void:
	_update_text()
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	AudioManager.toggle_music()
	_update_text()

func _update_text() -> void:
	text = "MUSIC: ON" if AudioManager._music_player.playing else "MUSIC: OFF"
