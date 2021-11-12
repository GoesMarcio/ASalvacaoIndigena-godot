extends KinematicBody2D


export var run_speed := 80
var velocity: Vector2 = Vector2.ZERO

var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null
var player_spotted: bool = false

onready var line2d = $Line2D
onready var los = $RayCast2D

#onready var target := get_tree().get_root().get_node("/root/Game/Beach/YSort/Player")
onready var target := get_tree().get_root().get_node("/root/Beach/YSort/Player")

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]



func _physics_process(delta):
	#follow_player(delta)
	line2d.global_position = Vector2.ZERO
	if player and player_spotted:
		generate_path()
	navigate()
	move()



func navigate():	# Define the next position to go to
	if path.size() > 1:
		#velocity = position.direction_to(path[1]) * run_speed
		velocity = (path[1] - position).normalized()
		
		# If reached the destination, remove this point from path array
		if euclidean_distance(position, path[0]) < 50:
			path.pop_front()
	elif path.size() == 1:
		velocity = (path[0] - position).normalized()
		# If reached the destination, remove this point from path array
		if euclidean_distance(position, path[0]) < 50:
			path.pop_front()
	else:
		velocity = Vector2.ZERO

func generate_path():
	if levelNavigation != null and player != null:
		if euclidean_distance(position, player.position) < 150:
			path = []
			line2d.points = []
		else:
			path = levelNavigation.get_simple_path(position, player.position, true)
			line2d.points = path

func move():
	move_and_slide(velocity * run_speed, Vector2.UP)

func follow_player(delta):
	if target == null:
		return
		
	var distance = sqrt(pow(target.position.x-position.x, 2) + pow(target.position.y-position.y,2))
	
	if(distance > 150):
		var direction = (target.position - position).normalized()
		print(direction)
		move_and_slide(direction * run_speed, Vector2.UP)


func euclidean_distance(a, b):
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_spotted = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_spotted = false
