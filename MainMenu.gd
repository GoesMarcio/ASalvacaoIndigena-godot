extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$VBoxContainer/StartGame.grab_click_focus()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_button_gui_input(event):
	if event.is_pressed():
		get_tree().change_scene("res://Scenarios/Tribe/Tribe2.tscn")

func _on_button3_gui_input(event):
	if event.is_pressed():
		get_tree().quit()



func _on_StartGame_mouse_entered():
	$VBoxContainer/StartGame.texture = load("res://assets/Images/button_hover.png")


func _on_StartGame_mouse_exited():
	$VBoxContainer/StartGame.texture = load("res://assets/Images/button.png")


func _on_Options_mouse_entered():
	$VBoxContainer/Options.texture = load("res://assets/Images/button_hover.png")


func _on_Options_mouse_exited():
	$VBoxContainer/Options.texture = load("res://assets/Images/button.png")


func _on_Quit_mouse_entered():
	$VBoxContainer/Quit.texture = load("res://assets/Images/button_hover.png")


func _on_Quit_mouse_exited():
	$VBoxContainer/Quit.texture = load("res://assets/Images/button.png")
