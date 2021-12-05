extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_bow_body_entered(body):
	if body.name == "Player":
		get_tree().call_group('Player', 'get_bow')
		get_tree().call_group('Player_indoor', 'get_bow')
		body.sprite_arrow = "yes"
		get_tree().call_group('Arrows_HUD', 'change_arrows', '10')
		queue_free()
