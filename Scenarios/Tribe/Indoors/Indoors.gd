extends Node2D

onready var sceneLimit := $Position2D
onready var player := $Player

func _physics_process(delta: float) -> void:
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene("res://Scenarios/Tribe/Tribe2.tscn")
		
