extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label := $Life


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_life(life):
	var life_int = int(life/10)
	#print(str(life) +" = "+ str(life_int))
	play(str(life_int))
	label.text = str(life)
	
