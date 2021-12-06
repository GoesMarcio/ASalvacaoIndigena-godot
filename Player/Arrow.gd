extends Area2D

onready var sprite := $AnimatedSprite
onready var shotSound := $Shot
onready var stuckEnemySound := $StuckEnemy
onready var stuckStructSound := $StuckStruct
onready var timer = $Timer

var speed = 500
var side_position = Vector2(1, 0)
var max_position = Vector2.ZERO
var init_position = Vector2.ZERO
var can_move = true

func _ready():
	shotSound.play()

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
	if can_move:
		position += side_position * speed * delta
		var aux_pos = max_position - init_position
		if aux_pos.x < 0 || aux_pos.y < 0:
			if position <= max_position:
				can_move = false
		if aux_pos.x > 0 || aux_pos.y > 0:
			if position >= max_position:
				can_move = false

func _on_Arrow_body_entered(body):
	if body.is_in_group("struct"):
		can_move = false
		stuckStructSound.play()
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

func set_position(pos):
	position = pos + (side_position * 15)
	init_position = position
	max_position = position + (side_position * 400)
	

func _on_Arrow_area_entered(area):
	if can_move:
		if area.is_in_group("Statue"):
			stuckStructSound.play()
			get_tree().call_group("Life", "update_life", 100)
			var root = get_node("/root/Game")	
			root.add_child(root.beach.instance())
			var city = get_node("/root/Game/City")
			city.queue_free()
			get_tree().call_group('hud', 'stopTimer')

		if area.is_in_group("Hitbox_enemy"):
			can_move = false
			stuckEnemySound.play()
			area.get_parent().receive_shot()
			
			#timer.set_wait_time(0.5)
			#timer.connect("timeout", self, "on_time_out_complete")
			#timer.start()
			
	else:
		if area.is_in_group("Hitbox_player"):
			get_tree().call_group('Player', 'get_arrow')
			queue_free()
		

func on_time_out_complete():
	queue_free()
