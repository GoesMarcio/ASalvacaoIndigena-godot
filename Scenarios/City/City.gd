extends Node2D

onready var structure_city = $Structure
onready var camera = $Structure/YSort/Player/Camera2D
onready var indoors1 = $Indors1
onready var indoors2 = $Indors2
onready var indoors3 = $Indors3
onready var bow = $bow

onready var player = $Structure/YSort/Player

var indoors_scene = null

var rng = RandomNumberGenerator.new()

func _ready():
	var indoors1_v = Vector2(0,1600)
	indoors1.position = Vector2(indoors1_v.x, indoors1_v.y)
	indoors1.camera.limit_left += indoors1_v.x
	indoors1.camera.limit_right += indoors1_v.x
	indoors1.camera.limit_top += indoors1_v.y
	indoors1.camera.limit_bottom += indoors1_v.y
	
	var indoors2_v = Vector2(1200,1600)
	indoors2.position = Vector2(indoors2_v.x, indoors2_v.y)
	indoors2.camera.limit_left += indoors2_v.x
	indoors2.camera.limit_right += indoors2_v.x
	indoors2.camera.limit_top += indoors2_v.y
	indoors2.camera.limit_bottom += indoors2_v.y
	
	var indoors3_v = Vector2(2400,1600)
	indoors3.position = Vector2(indoors3_v.x, indoors3_v.y)
	indoors3.camera.limit_left += indoors3_v.x
	indoors3.camera.limit_right += indoors3_v.x
	indoors3.camera.limit_top += indoors3_v.y
	indoors3.camera.limit_bottom += indoors3_v.y
	
	rng.randomize()
	var rand = rng.randi_range(1, 3)
	match rand:
		1:
			bow.position = Vector2(290, 1822)
		2:
			bow.position = Vector2(1885, 1780)
		3:
			bow.position = Vector2(3125, 1772)



func _on_Predio_player_enter(building):
	match building:
		1:
			indoors_scene = indoors2
		2:
			indoors_scene = indoors1
		3:
			indoors_scene = indoors3
	
	change_state_city(false)
	structure_city.hide()

	indoors_scene.show()
	indoors_scene.camera.current = true
	camera.current = false
	
	indoors_scene.player.side_position  = Vector2(0,-1)
	indoors_scene.player.change_skin()

func change_state_city(state):
	get_tree().call_group('Player', 'change_can_move', state)
	get_tree().call_group('enemy', 'change_can_move', state)

	indoors_scene.player.change_can_move(!state)

func player_exit():
	print("sai")
	indoors_scene.camera.current = false
	camera.current = true
	structure_city.show()
	indoors_scene.hide()
	change_state_city(true)
	indoors_scene = null
	
	player.side_position  = Vector2(0,1)
	player.change_skin()
