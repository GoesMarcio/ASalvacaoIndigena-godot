extends Label

onready var time := 60.0

func startTimer():
	get_parent().visible = true

func stopTimer():
	queue_free()
	get_parent().queue_free()

func updateTime(delta):
	if visible:
		time -= delta
		var time_min = str(int(time)/60)
		if len(time_min) < 2:
			time_min = "0"+time_min
		var time_sec = str(int(time) % 60)
		if len(time_sec) < 2:
			time_sec = "0"+time_sec
			
		text = "Tempo restante: " + str(time_min) +":"+str(time_sec)
