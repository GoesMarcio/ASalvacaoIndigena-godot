extends Area2D

onready var sprite := $AnimatedSprite
var speed = 500
var side_position = Vector2(1, 0)


func _physics_process(delta):
	position += side_position * speed * delta

func _on_Arrow_body_entered(body):
	print(body.name)
	return
	if body.is_in_group("Player"):
		body.receive_shot()
		#body.queue_free()
		queue_free()

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


func _on_Shot_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().call_group('Player', 'receive_shot')
		#body.queue_free()
		queue_free()
