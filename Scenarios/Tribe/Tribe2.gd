extends Node2D

onready var sceneLimit := $mapa/Position2D
onready var player := $YSort/Player

onready var root = get_node("/root/Game")	

func _physics_process(_delta: float) -> void:
	if root.story.has("talked") and player.position.x > sceneLimit.position.x:
		get_parent().add_child(get_parent().city.instance())
		self.queue_free()
