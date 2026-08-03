extends Node

var Bosses_Beaten = []
var cow_cactus_defeated := false
var coffin_defeated := false

var is_grave_digger_coyote : bool = false

var played_npc_stages: Dictionary = {} # npc_key -> Array[String] stage resource paths

func get_npc_key(scene_path: String, npc_name: String) -> String:
	return scene_path + "::" + npc_name


func mark_npc_stage_played(npc_key: String, stage_path: String) -> void:
	var played: Array = played_npc_stages.get(npc_key, [])
	if not played.has(stage_path):
		played.append(stage_path)
	played_npc_stages[npc_key] = played


func is_npc_stage_played(npc_key: String, stage_path: String) -> bool:
	var played: Array = played_npc_stages.get(npc_key, [])
	return played.has(stage_path)

func if_he_choosed_not_to():
	print("YOU SHOULD RETURN TO MAIN MENU")
	pass

func set_coyote_disquise():
	is_grave_digger_coyote = true
	
	
