extends Control

func _on_button_gui_input(event):
	if event.is_pressed():
		get_parent().add_child(get_parent().tribe.instance())
		self.queue_free()

func _on_button3_gui_input(event):
	if event.is_pressed():
		get_tree().quit()

func _on_StartGame_mouse_entered():
	$VBoxContainer/StartGame.texture = load("res://assets/Images/button_hover.png")


func _on_StartGame_mouse_exited():
	$VBoxContainer/StartGame.texture = load("res://assets/Images/button.png")


func _on_Quit_mouse_entered():
	$VBoxContainer/Quit.texture = load("res://assets/Images/button_hover.png")


func _on_Quit_mouse_exited():
	$VBoxContainer/Quit.texture = load("res://assets/Images/button.png")
