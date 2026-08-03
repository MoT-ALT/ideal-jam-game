class_name NPCDialogStage
extends Resource

enum Condition { ALWAYS, BOSS_DEFEATED, BOSS_NOT_DEFEATED }

@export_group("Dialog")
@export var dialog_data: SproutyDialogsDialogueData
@export var start_id: String = "1"

@export_group("Condition")
@export var condition: Condition = Condition.ALWAYS
@export var boss_key: String = ""
@export var one_shot: bool = true
