extends KinematicBody2D

class_name Player

export var run_speed := 150
export var gravity := 35
export var turn := 'down'
export var sprite_arrow := 'no'
export var can_move := true

onready var sprite := $AnimatedSprite
onready var life := 100
onready var moving := false

onready var bullet := preload("res://Player/Arrow.tscn")
onready var n_arrows := 10

var side_position := Vector2(0,1)
var velocity := Vector2()

func _ready() -> void:
	if turn == 'up':
		sprite.play(sprite_arrow + '_up')
		sprite.stop()
	elif turn == 'right':
		sprite.play(sprite_arrow + '_right')
		sprite.stop()
	elif turn == 'left':
		sprite.play(sprite_arrow + '_left')
		sprite.stop()
	else:
		sprite.play(sprite_arrow + '_down')
		sprite.stop()

	
# Movimento lateral com gravidade
func get_input_side():
	if !can_move:
		sprite.stop()
		return
	
	velocity.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * run_speed
	
	if velocity.x > 0:		
		sprite.play(sprite_arrow + "_right")
		side_position = Vector2(1,0)
	elif velocity.x < 0:
		sprite.play(sprite_arrow + "_left")
		side_position = Vector2(-1,0)
	elif velocity.y > 0:
		sprite.play(sprite_arrow + "_down")
		side_position = Vector2(0,1)
	elif velocity.y < 0:
		sprite.play(sprite_arrow + "_up")
		side_position = Vector2(0,-1)
	else:
		sprite.stop()
		
	# Arrow
	if sprite_arrow == "yes" and Input.is_action_just_pressed("space"):
		shot()

func _physics_process(delta):
	if !can_move:
		sprite.stop()
		return
	get_input_side()
	velocity = move_and_slide(velocity, Vector2.UP)

func shot():
	if n_arrows > 0:
		n_arrows -= 1
		get_tree().call_group('Arrows_HUD', 'change_arrows', str(n_arrows))
		var b := bullet.instance()
		get_parent().add_child(b)
		b.change_side(side_position)
		b.set_position(position)
		
		if n_arrows == 0:
			sprite_arrow = "yesn"
			change_skin()

func change_skin():
	if side_position == Vector2(0,-1):
		sprite.play(sprite_arrow + '_up')
		sprite.stop()
	elif side_position  == Vector2(1,0):
		sprite.play(sprite_arrow + '_right')
		sprite.stop()
	elif side_position  == Vector2(-1,0):
		sprite.play(sprite_arrow + '_left')
		sprite.stop()
	else:
		sprite.play(sprite_arrow + '_down')
		sprite.stop()

func change_can_move(can):
	can_move = can

func receive_shot():
	life -= 2
	get_tree().call_group("Life", "update_life", life)
	if life <= 0:
		get_tree().call_group("Game", "game_over")
		queue_free()

func get_arrow():
	n_arrows += 1
	get_tree().call_group('Arrows_HUD', 'change_arrows', str(n_arrows))
	if n_arrows > 0:
		sprite_arrow = "yes"
		change_skin()
