extends Node2D

onready var camera = $YSort/Player/Camera2D
onready var player = $YSort/Player
export var default_pos_player = Vector2(515,520)

func _on_Door_Indoor_body_entered(body):
	if body.name == "Player":
		set_default_pos_player()
		get_tree().call_group('City', 'player_exit')

func set_default_pos_player():
	player.position = default_pos_player
