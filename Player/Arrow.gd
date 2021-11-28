extends Area2D

onready var sprite := $AnimatedSprite
onready var shotSound := $Shot
onready var stuckEnemySound := $StuckEnemy
onready var stuckStructSound := $StuckStruct
onready var timer = $Timer

var speed = 500
var side_position = Vector2(1, 0)
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

func _on_Arrow_body_entered(body):
	if body.is_in_group("struct"):
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


func _on_Arrow_area_entered(area):
	if area.is_in_group("Statue"):
		stuckStructSound.play()
		var root = get_node("/root/Game")	
		root.add_child(root.beach.instance())
		var city = get_node("/root/Game/City")
		city.queue_free()
		get_tree().call_group('hud', 'stopTimer')

	if area.is_in_group("Hitbox_enemy"):
		visible = false
		can_move = false
		stuckEnemySound.play()
		area.get_parent().receive_shot()
		
		timer.set_wait_time(0.5)
		timer.connect("timeout", self, "on_time_out_complete")
		timer.start()

func on_time_out_complete():
	queue_free()
