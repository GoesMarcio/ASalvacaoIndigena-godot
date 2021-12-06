extends CanvasLayer

onready var root = get_node("/root/Game")

func _ready():
	get_tree().call_group('hud', 'stopTimer')


func _on_Quit_gui_input(event):
	if event.is_pressed():
		get_tree().quit()
