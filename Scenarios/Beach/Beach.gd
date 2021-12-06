extends Node2D

onready var enemies_label := $CanvasLayer/Panel/Label
onready var enemies := 0

func _ready():
	get_tree().call_group('Arrows_HUD', 'change_arrows', '10')

func enemy_die():
	enemies += 1
	enemies_label.text = str(enemies) + "/12"
	if enemies == 12:
		get_tree().call_group('Life', 'changeVisible', false)
		get_tree().call_group('Arrows_HUD', 'change_arrows', '0')
		var root = get_node("/root/Game")	
		root.add_child(root.future.instance())
		var beach = get_node("/root/Game/Beach")
		beach.queue_free()
