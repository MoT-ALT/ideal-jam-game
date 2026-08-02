extends Node

var player: AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)
	var sd := get_node("/root/SproutyDialogs")
	sd.line_processed.connect(_on_line_processed)
	sd.dialog_ended.connect(stop_voice)

func _on_line_processed(_character_name: String, dialog_key: String, dialog_name: String) -> void:
	stop_voice()
	if not dialog_key.is_empty():
		play_voice(dialog_name + "_" + dialog_key)

func play_voice(voice_id: String) -> void:
	var stream := load("res://dialogs/voices/" + voice_id + ".ogg") as AudioStream
	if stream == null:
		return
	player.stream = stream
	player.play()

func stop_voice() -> void:
	player.stop()
