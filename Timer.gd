extends Label

onready var time := 0

func startTimer():
	visible = true

func updateTime():
	if visible:
		time += 1
		text = "Tempo restante: " + str(time)
