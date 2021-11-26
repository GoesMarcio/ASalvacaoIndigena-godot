extends CanvasLayer

func _ready():
	get_tree().call_group('hud', 'stopTimer')
