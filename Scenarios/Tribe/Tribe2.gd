extends Node2D

onready var sceneLimit := $mapa/Position2D
onready var player := $YSort/Player


func _physics_process(delta: float) -> void:
	pass
	#if player.position.x > sceneLimit.position.x:
		#get_tree().change_scene("res://Scenarios/City/City_collision.tscn")
		
