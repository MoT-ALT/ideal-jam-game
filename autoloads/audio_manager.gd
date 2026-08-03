extends Node

const SHOOTING := preload("res://SFX/shooting.wav")
const HIT := preload("res://SFX/hit hurt sound.wav")
const TEXT_SKIP := preload("res://SFX/text skip.wav")
const DIGGING := preload("res://SFX/coffin digging.wav")
const MUSIC := preload("res://vacaroxa--generic-old-west-graphics--v.1.0/Audio/01 - Welcome To The Wild West.ogg")

var _players: Dictionary = {}
var _music_player: AudioStreamPlayer


func _ready() -> void:
	_players["shooting"] = _make_player(SHOOTING)
	_players["hit"] = _make_player(HIT)
	_players["text_skip"] = _make_player(TEXT_SKIP)
	_players["digging"] = _make_player(DIGGING)
	_music_player = _make_player(MUSIC)
	_music_player.volume_db = -10.0
	start_music()


func _make_player(stream: AudioStream) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	return player


func play_shooting() -> void:
	_play("shooting")


func play_hit() -> void:
	_play("hit")


func start_music() -> void:
	if not _music_player.playing:
		_music_player.play()


func stop_music() -> void:
	_music_player.stop()


func toggle_music() -> bool:
	if _music_player.playing:
		stop_music()
		return false
	start_music()
	return true


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
