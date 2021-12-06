extends Area2D

onready var sprite := $AnimatedSprite
onready var shotSound := $Shot
onready var painSound := $PainSound
onready var timer = $Timer
var speed = 500
var side_position = Vector2(1, 0)

var can_move = true

func _ready():
	shotSound.play()

func _physics_process(delta):
	if can_move:
		position += side_position * speed * delta


func change_side(side):
	side_position = side
	if(side == Vector2.RIGHT):
		sprite.play("right")
	if(side == Vector2.LEFT):
		sprite.play("left")
	if(side == Vector2.UP):
		sprite.play("down")
	if(side == Vector2.DOWN):
		sprite.play("up")


func _on_Shot_area_entered(area):
	if area.is_in_group("Hitbox_player"):
		visible = false
		can_move = false
		get_tree().call_group('Player', 'receive_shot')
		painSound.play()
		timer.set_wait_time(0.8)
		timer.connect("timeout", self, "on_time_out_complete")
		timer.start()

func on_time_out_complete():
	queue_free()


func _on_Shot_body_entered(body):
	if body.is_in_group("struct"):
		queue_free()
