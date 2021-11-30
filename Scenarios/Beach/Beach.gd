extends Node2D

func _ready():
	get_tree().call_group('Arrows_HUD', 'change_arrows', '10')
