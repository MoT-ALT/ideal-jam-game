extends Button

@export var st : SceneTransition

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/tile_map_layer.tscn")
