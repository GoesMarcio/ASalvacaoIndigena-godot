extends KinematicBody2D


onready var sprite := $AnimatedSprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var side_position = Vector2(1, 0)
var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_side(side):
	side_position = side
	if(side == Vector2(1,0)):
		sprite.play("right")
	if(side == Vector2(-1,0)):
		sprite.play("left")
	if(side == Vector2(0,1)):
		sprite.play("down")
	if(side == Vector2(0,-1)):
		sprite.play("up")

func _physics_process(delta):
	position = position + (side_position * 5)
	
