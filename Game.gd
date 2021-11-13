extends Node2D

var position_player = Vector2()
var hut = preload("res://Scenarios/Tribe/Indoors/Indoors.tscn")
var tribe = preload("res://Scenarios/Tribe/Tribe2.tscn")
var beach = preload("res://Scenarios/Beach/Beach.tscn")
var city = preload("res://Scenarios/City/City_collision.tscn")
var dialog = preload("res://assets/Dialog/Dialog.tscn")

onready var story := []

func _physics_process(delta):
	if story.has("talked"):
		get_tree().call_group('hud', 'updateTime', delta)

func save_player_pos(position):
	position_player = position
	
func return_player_position(scene, dis, look):
	scene.player.position = position_player - dis
	scene.player.sprite.play(look)
	scene.player.sprite.stop()
