extends Node2D

onready var sceneLimit := $mapa/Position2D
onready var player := $YSort/Player
onready var timer := self.get_parent().get_node('Canvas').get_node('Timer')

func _physics_process(_delta: float) -> void:
	get_tree().call_group('hud', 'updateTime')
	
	if player.position.x > sceneLimit.position.x and timer.visible:
		get_parent().add_child(get_parent().city.instance())
		self.queue_free()
		
