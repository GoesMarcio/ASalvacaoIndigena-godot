extends Area2D

export(PackedScene) var target_scene

func _physics_process(delta: float) -> void:
	if get_overlapping_bodies().size() > 1:
		next_level()
			
func next_level():
	var ERR = get_tree().change_scene("res://Scenarios/Tribe/Indoors/Indoors.tscn")
	
	if ERR != OK:
		print("something failed in the door scene")
