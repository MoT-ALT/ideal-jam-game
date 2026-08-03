extends Node

const SHOOTING := preload("res://SFX/shooting.wav")
const HIT := preload("res://SFX/hit hurt sound.wav")
const WALKING := preload("res://SFX/walking.wav")
const TEXT_SKIP := preload("res://SFX/text skip.wav")
const DIGGING := preload("res://SFX/coffin digging.wav")

var _players: Dictionary = {}


func _ready() -> void:
	_players["shooting"] = _make_player(SHOOTING)
	_players["hit"] = _make_player(HIT)
	_players["walking"] = _make_player(WALKING)
	_players["text_skip"] = _make_player(TEXT_SKIP)
	_players["digging"] = _make_player(DIGGING)


func _make_player(stream: AudioStream) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	return player


func play_shooting() -> void:
	_play("shooting")


func play_hit() -> void:
	_play("hit")


func play_walking() -> void:
	var player: AudioStreamPlayer = _players["walking"]
	if player.playing:
		return
	player.play()


func stop_walking() -> void:
	var player: AudioStreamPlayer = _players["walking"]
	player.stop()


func play_text_skip() -> void:
	_play("text_skip")


func play_digging() -> void:
	_play("digging")


func _play(sfx: String) -> void:
	var player: AudioStreamPlayer = _players.get(sfx)
	if player == null:
		return
	if player.playing:
		player.stop()
	player.pitch_scale = randf_range(0.9, 1.1)
	player.play()
