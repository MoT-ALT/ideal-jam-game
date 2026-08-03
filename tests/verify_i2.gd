extends Node

func _ready() -> void:
	var ps := load("res://UI/i2.tscn") as PackedScene
	if ps == null:
		print("FAIL: cannot load i2.tscn")
		get_tree().quit(1)
		return
	var inst := ps.instantiate()
	add_child(inst)
	await get_tree().process_frame
	await get_tree().process_frame
	var npc: Node = inst.get_node_or_null("CactusNPC")
	if npc == null:
		print("FAIL: CactusNPC not found")
		get_tree().quit(1)
		return
	print("CactusNPC found at ", npc.position)
	var sprite: Sprite2D = npc.get_node("Sprite")
	print("sprite texture=", sprite.texture.resource_path)
	print("sprite hframes=", sprite.hframes, " vframes=", sprite.vframes, " frame=", sprite.frame, " flip_h=", sprite.flip_h)
	var stage: Array = npc.get("dialogs")
	print("dialogs count=", stage.size())
	var stage_res: Resource = stage[0]
	print("stage dialog_data=", stage_res.get("dialog_data").resource_path)
	print("stage start_ids=", stage_res.get("dialog_data").get_start_ids())
	get_tree().quit(0)
