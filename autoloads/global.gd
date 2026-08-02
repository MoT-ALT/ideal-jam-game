extends Node

var player: AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)

func on_getting_dialog(dialog_id:String):
	var stream := load("res://dialogs/voices/" + dialog_id + ".ogg") as AudioStream
	player.stream = stream
	player.play()
	return
