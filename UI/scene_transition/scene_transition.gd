extends CanvasLayer

var current_scene = "res://UI/tile_map_layer.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func load_scene(scene:String):
	animation_player.play("circle_in")
	await animation_player.animation_finished
	current_scene = scene
	get_tree().change_scene_to_file(scene)
	
func init_scene():
	animation_player.play("circle_out")
