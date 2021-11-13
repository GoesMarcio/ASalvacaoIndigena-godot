extends Area2D

onready var dialog := $"Dialog Box"
onready var root = get_node("/root/Game")
onready var hut = get_node("/root/Game/Hut")
onready var di = root.dialog.instance()

func _on_OldIndian_body_entered(body: Node) -> void:
	if body.name == 'Player':
		dialog.visible = true


func _on_OldIndian_body_exited(body: Node) -> void:
	dialog.visible = false
	
func _physics_process(delta: float) -> void:
	# Dialog
	if dialog.visible and Input.is_action_just_pressed("space"):
		hut.add_child(di)
