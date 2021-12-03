extends KinematicBody2D

export var max_life := 100
var life = max_life

export var can_move := true
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
onready var progressLife = $ProgressBar
onready var sprite := $AnimatedSprite

onready var bullet := preload("res://Enemies/Shot.tscn")
var timer = null
var can_shot = false
var can_walk = true

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
	can_shot = true
	can_walk = true

func _physics_process(delta):
	if !can_move:
		return

	if !get_tree().has_group("Player"):
		player == null
		
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
			sprite.stop()
			state = WAIT
			path.pop_front()
	else:
		velocity = Vector2.ZERO

func generate_path():
	if levelNavigation != null and player != null:
		var side = get_closer_side()
		if euclidean_distance(position, side[1]) < 5 || euclidean_distance(position, player.position) < 200:
			var d = check_axis(side[0])
			if !d[0]:
				sprite.stop()
				state = ATTACK
				path = [re_distance(position, player.position)]
				line2d.points = []
			else:
				state = MOVE
				path = levelNavigation.get_simple_path(position, position + d[1], true)
				line2d.points = path
		else:
			state = MOVE
			path = levelNavigation.get_simple_path(position, side[1], true)
			line2d.points = path

func check_axis(side):
	match side:
		0:
			var aux = position - player.position
			return [abs(aux.y) < 50, aux]
		1:
			var aux = position - player.position
			return [abs(aux.y) < 50, aux]
		2:
			var aux = position - player.position
			return [abs(aux.x) < 50, aux]
		3:
			var aux = position - player.position
			return [abs(aux.x) < 50, aux]

func get_closer_side():
	var distance = 200
	var sides = [player.position + Vector2(0, distance), player.position + Vector2(0, -distance), player.position + Vector2(distance, 0), player.position + Vector2(-distance, 0)]
	var result = -1
	var aux = [-1, Vector2.ZERO]
	
	for i in range(sides.size()):
		var d = euclidean_distance(position, sides[i])
		if result == -1 || d < result:
			result = d
			aux[0] = i
			aux[1] = sides[i]
	
	return aux

func move():
	match state:
		MOVE:
			if can_walk:
				if abs(velocity.x) > abs(velocity.y):
					if velocity.x > 0:
						sprite.play("right")
					elif velocity.x < 0:
						sprite.play("left")
				else:
					if velocity.y > 0:
						sprite.play("down")
					elif velocity.y < 0:
						sprite.play("up")
				if velocity == Vector2.ZERO:
					sprite.stop()
				move_and_slide(velocity * run_speed, Vector2.UP)
		ATTACK:
			shot()

func shot():
	if !get_tree().has_group("Player"):
		player == null
		return

	if can_shot:
		can_walk = false
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
	progressLife.value = (life * 100 / max_life)
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



func change_can_move(can):
	can_move = can
