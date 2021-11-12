extends Node2D

onready var sceneLimit := $mapa/Position2D
onready var player := $YSort/Player
onready var timer := self.get_parent().get_node('Canvas').get_node('Timer')

onready var root = get_node("/root/Game")	


func _physics_process(_delta: float) -> void:
	get_tree().call_group('hud', 'updateTime', _delta)
	
	if root.story.has("talked") and player.position.x > sceneLimit.position.x and timer.visible:
		get_parent().add_child(get_parent().city.instance())
		self.queue_free()
