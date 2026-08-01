extends Node2D

const HITS_TO_KILL := 4
const DRAW_DELAY_MIN := 0.8
const DRAW_DELAY_MAX := 1.6
const ROUND_TIME := 2.0
const HIT_PAUSE := 1.0
const BETWEEN_ROUNDS := 2.0
const BASE_ZONE := 200.0
const ZONE_DECAY := 40.0
const MIN_ZONE := 70.0
const SWEEP_SPEED_BASE := 1.0
const SWEEP_SPEED_STEP := 0.25
const BAR_WIDTH := 600.0

var player_hits := 0
var round := 0
var round_active := false
var window_open := false
var round_token := 0
var zone_width := BASE_ZONE
var sweep_t := 0.0
var sweeping := false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_node("../Player")
@onready var draw_label: Label = get_node("../UI/Control/DrawLabel")
@onready var bar_background: ColorRect = get_node("../UI/Control/BarBackground")
@onready var bar_target: ColorRect = get_node("../UI/Control/BarTarget")
@onready var bar_marker: ColorRect = get_node("../UI/Control/BarMarker")


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	animation_player.play("intro")
	animated_sprite_2d.play("Walk")


func _process(delta: float) -> void:
	if not sweeping:
		return
	bar_marker.visible = true
	sweep_t += delta * (SWEEP_SPEED_BASE + SWEEP_SPEED_STEP * (round - 1))
	var pos := absf(fposmod(sweep_t, 2.0) - 1.0)
	var center := -BAR_WIDTH / 2.0 + pos * BAR_WIDTH
	bar_marker.offset_left = center - 4.0
	bar_marker.offset_right = center + 4.0


func _hide_bar() -> void:
	bar_background.visible = false
	bar_target.visible = false
	bar_marker.visible = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		animated_sprite_2d.play("Idle")
		start_quickdraw()


func _play_intro_dialog() -> void:
	var sprouty := get_node("/root/SproutyDialogs")
	var dialog: Resource = load("res://dialogs/cactus_intro.tres")
	var dialog_player: Node = sprouty.start_dialog(dialog, "cactus_intro")
	await dialog_player.dialog_ended


func start_quickdraw() -> void:
	round += 1
	round_active = true
	sweeping = false
	window_open = false
	bar_marker.offset_left = -BAR_WIDTH / 2.0 - 4.0
	bar_marker.offset_right = -BAR_WIDTH / 2.0 + 4.0
	bar_marker.visible = false
	animated_sprite_2d.play("Idle")
	player.reset_duel()
	_run_round()


func _run_round() -> void:
	round_token += 1
	var token := round_token
	draw_label.text = "Get ready..."
	await get_tree().create_timer(randf_range(DRAW_DELAY_MIN, DRAW_DELAY_MAX)).timeout
	if token != round_token or not round_active:
		return
	window_open = true
	zone_width = maxf(BASE_ZONE - ZONE_DECAY * (round - 1), MIN_ZONE)
	bar_target.offset_left = -zone_width / 2.0
	bar_target.offset_right = zone_width / 2.0
	sweep_t = 0.0
	sweeping = true
	draw_label.text = "DRAW!"
	await get_tree().create_timer(ROUND_TIME).timeout
	if token != round_token or not round_active:
		return
	round_active = false
	window_open = false
	sweeping = false
	draw_label.text = "Too slow!"
	boss_fires()


func player_draw() -> void:
	if not round_active:
		return
	if not window_open:
		draw_label.text = "Too early, wait for the draw!"
		_run_round()
		return
	round_active = false
	window_open = false
	sweeping = false
	var marker_offset := absf(bar_marker.offset_left + 4.0)
	if marker_offset <= zone_width / 2.0:
		player_hits += 1
		draw_label.text = "HIT! %d/%d" % [player_hits, HITS_TO_KILL]
		player.fire()
		await get_tree().create_timer(0.35).timeout
		animated_sprite_2d.play("Hit")
		if player_hits >= HITS_TO_KILL:
			await get_tree().create_timer(0.9).timeout
			draw_label.text = "VICTORY!"
			_hide_bar()
			var tween := create_tween()
			tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 1.2)
			return
		await get_tree().create_timer(HIT_PAUSE).timeout
		animated_sprite_2d.play("Idle")
		draw_label.text = ""
		await get_tree().create_timer(BETWEEN_ROUNDS).timeout
		start_quickdraw()
	else:
		draw_label.text = "MISS!"
		boss_fires()


func boss_fires() -> void:
	player.duel_active = false
	animated_sprite_2d.play("Shoot")
	await get_tree().create_timer(1.2).timeout
	player.play_death()
	await get_tree().create_timer(0.9).timeout
	draw_label.text = "YOU LOSE!"
