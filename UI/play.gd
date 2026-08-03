extends Button

func _ready() -> void:
	SceneTransitionManager.init_scene()
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	SceneTransitionManager.load_scene("res://UI/tile_map_layer.tscn")
