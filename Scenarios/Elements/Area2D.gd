extends Area2D

export(PackedScene) var target_scene

#var hut = preload("res://Scenarios/Tribe/Indoors/Indoors.tscn").instance()

func _physics_process(delta: float) -> void:
	if get_overlapping_bodies().size() > 1:
		next_level()
			
func next_level():

	var root = get_node("/root/Game")
	var tribe = get_node("/root/Game/Tribe")
	
	root.save_player_pos(tribe.player.position)
	root.add_child(root.hut.instance())
	tribe.queue_free()
