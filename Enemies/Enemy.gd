extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var run_speed := 80

onready var target := get_tree().get_root().get_node("/root/Game/Tribe/YSort/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	follow_player(delta)


func follow_player(delta):
	var distance = sqrt(pow(target.position.x-position.x, 2) + pow(target.position.y-position.y,2))
	
	if(distance > 50):
		var direction = (target.position - position).normalized()
		print(direction)
		move_and_slide(direction * run_speed, Vector2.UP)
