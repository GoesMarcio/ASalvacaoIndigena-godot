extends KinematicBody2D

export var max_life := 100
var life = max_life

export var run_speed := 80
var velocity: Vector2 = Vector2.ZERO

enum {
	MOVE,
	ATTACK,
	WAIT
}

var state := WAIT
var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null
var player_spotted: bool = false

onready var line2d = $Line2D
onready var rc = $RayCast2D

onready var bullet := preload("res://Enemies/Shot.tscn")
var timer = null
var can_shot = false

func _ready():
	timer = get_node("Timer")
	timer.set_wait_time(2)
	timer.connect("timeout", self, "on_time_out_complete")
	timer.start()
	
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
		
	print(levelNavigation)
	print(player)

func on_time_out_complete():
	print("atirei")
	can_shot = true

func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	if player and player_spotted:
		generate_path()
	
	navigate()
	move()

func check_player_in_detection() -> bool:
	var collider = rc.get_collider()
	if collider:
		print(collider.name)
		player_spotted = true
		print("raycast collided")	# Debug purposes
		return true
	player_spotted = false
	return false


func navigate():
	if path.size() > 1:
		velocity = (path[1] - position).normalized()
		
		if euclidean_distance(position, path[0]) < 50:
			path.pop_front()
	elif path.size() == 1:
		velocity = (path[0] - position).normalized()
		if euclidean_distance(position, path[0]) < 50:
			state = WAIT
			path.pop_front()
	else:
		velocity = Vector2.ZERO

func generate_path():
	if levelNavigation != null and player != null:
		if euclidean_distance(position, player.position) < 250:
			state = ATTACK
			path = [re_distance(position, player.position)]
			line2d.points = []
		else:
			state = MOVE
			path = levelNavigation.get_simple_path(position, player.position, true)
			line2d.points = path

func move():
	match state:
		MOVE:
			move_and_slide(velocity * run_speed, Vector2.UP)
		ATTACK:
			shot()

func shot():
	if can_shot:
		var b := bullet.instance()
		b.position = position
		get_parent().add_child(b)
		b.change_side(direction_shot())
		can_shot = false

func euclidean_distance(a, b):
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))

func check_distance(a, b):
	if abs(a.x - b.x) < 200:
		return true
	if abs(a.y - b.y) < 200:
		return true
	return false


func re_distance(a, b):
	if abs(a.x - b.x) < 200:
		return Vector2(0, b.y)
	if abs(a.y - b.y) < 200:
		return Vector2(b.x, 0)
	return Vector2.ZERO

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_spotted = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_spotted = false

func receive_shot():
	life -= 50
	if(life <= 0):
		queue_free()


func direction_shot():
	var d = (position - player.position)
	var a = d.abs()
	
	if a.x > a.y:
		if d.x > 0:
			return Vector2.LEFT
		else:
			return Vector2.RIGHT
	else:
		if d.y > 0:
			return Vector2.UP
		else:
			return Vector2.DOWN
