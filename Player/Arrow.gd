extends Area2D


onready var sprite := $AnimatedSprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 500

var side_position = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_parent())
	print(get_parent().name)
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

#func _physics_process(delta):
#	position = position + (side_position * 5)


func _physics_process(delta):
	position += side_position * speed * delta

func _on_Arrow_body_entered(body):
	print(body.name)
	if body.is_in_group("enemy"):
		print(body)
		body.queue_free()
		queue_free()
		
	if body.is_in_group("struct"):
		stuck(side_position)
		side_position = Vector2(0,0)

func stuck(side):
	if(side == Vector2(1,0)):
		sprite.play("stuck_right")
	if(side == Vector2(-1,0)):
		sprite.play("stuck_left")
	if(side == Vector2(0,1)):
		sprite.play("stuck_down")
	if(side == Vector2(0,-1)):
		sprite.play("stuck_up")


func _on_Arrow_area_entered(area):
	if area.is_in_group("Statue"):
		var root = get_node("/root/Game")	
		root.add_child(root.beach.instance())
		var city = get_node("/root/Game/City")
		city.queue_free()
