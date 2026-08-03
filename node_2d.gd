extends Node2D

func _ready() -> void:
	var labels = [%THEEND, %THEEND2, %THEEND3, %THEEND4, %THEEND5, %THEEND6,
		%THEEND7, %THEEND8, %THEEND9, %THEEND10, %THEEND11, %THEEND12, %THEEND13]

	# Hide all labels immediately so nothing shows before its turn
	for label in labels:
		label.visible = false
		label.modulate.a = 0.0

	# Now reveal them one by one, 4 seconds apart
	for label in labels:
		label.fade_in_out()
		await get_tree().create_timer(5.0).timeout

func _process(delta: float) -> void:
	pass
	
