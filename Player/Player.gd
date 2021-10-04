extends KinematicBody2D

export var run_speed := 100
export var gravity := 35
onready var sprite := $AnimatedSprite

#onready var bullet := preload("res://Weapons/Bullet.tscn")
export (PackedScene) var bullet : PackedScene
	
var velocity := Vector2()
	
# Movimento lateral com gravidade
func get_input_side():
	velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * run_speed

	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		

	
	
func _physics_process(delta):
	get_input_side()
	velocity = move_and_slide(velocity, Vector2.UP)
