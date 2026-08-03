extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	SceneTransitionManager.load_scene("res://UI/tile_map_layer.gd")
