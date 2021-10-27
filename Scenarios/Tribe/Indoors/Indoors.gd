extends Node2D

onready var sceneLimit := $Position2D
onready var player := $Player

func _physics_process(delta: float) -> void:
	
	if player.position.y > sceneLimit.position.y:
		var root = get_node("/root/Game")	
		root.add_child(root.tribe.instance())
		
		var tribe = get_node("/root/Game/Tribe")	
		root.return_player_position(tribe, Vector2(0,-20), 'down')
		
		self.queue_free()
