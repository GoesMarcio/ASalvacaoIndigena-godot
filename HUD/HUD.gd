extends AnimatedSprite

onready var label := $Life

func update_life(life):
	var life_int = int(life/10)
	#print(str(life) +" = "+ str(life_int))
	play(str(life_int))
	label.text = str(life)
	
func changeVisible(visible):
	self.visible = visible
