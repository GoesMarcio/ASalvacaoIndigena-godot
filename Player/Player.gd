extends KinematicBody2D

class_name Player

export var run_speed := 150
export var gravity := 35
export var turn := 'down'

onready var sprite := $AnimatedSprite
onready var life := 100

onready var bullet := preload("res://Player/Arrow.tscn")
#export (PackedScene) var bullet : PackedScene

var side_position := Vector2(0,1)
var velocity := Vector2()

func _ready() -> void:
	if turn == 'up':
		sprite.play('up')
		sprite.stop()
	elif turn == 'right':
		sprite.play('right')
		sprite.stop()
	elif turn == 'left':
		sprite.play('left')
		sprite.stop()
	else:
		sprite.play('down')
		sprite.stop()

	
# Movimento lateral com gravidade
func get_input_side():
	velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * run_speed
	
	if velocity.x != 0:
		life -= abs(velocity.x/1000)
		get_tree().call_group("Life_HUD", "update_life", life)
	
	if velocity.x > 0:
		sprite.play("right")
		side_position = Vector2(1,0)
	elif velocity.x < 0:
		sprite.play("left")
		side_position = Vector2(-1,0)
	elif velocity.y > 0:
		sprite.play("down")
		side_position = Vector2(0,1)
	elif velocity.y < 0:
		sprite.play("up")
		side_position = Vector2(0,-1)
	else:
		sprite.stop()
		
	# Arrow
	if Input.is_action_just_pressed("space"):
		shoot()

func _physics_process(delta):
	get_input_side()
	velocity = move_and_slide(velocity, Vector2.UP)

func shoot():
	var b := bullet.instance()
	b.position = position
	get_parent().add_child(b)
	b.change_side(side_position)
