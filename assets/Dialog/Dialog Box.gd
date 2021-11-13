extends Control

onready var root = get_node("/root/Game")
onready var oldIndian = get_node("/root/Game/Hut/YSort/OldIndian")

var dialog = [
	'oien',
	'fala tu padrinho',
	'qual a boa do find meu cpx',
	'satisfacao afu cpx'
]

var dialog_index = 0
var finished = false

func _ready():
	if root.story.has("talked"):
		dialog = ['que tu quer aqui dnv fdp',
		'larga da volta pnc'
		]
	
func _process(delta: float) -> void:
	$"next-phase".visible = finished
	if oldIndian.dialog.visible and Input.is_action_just_pressed("space"):
		load_dialog()
	
func load_dialog():
	if dialog_index < dialog.size():
		self.visible = true
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		dialog_index += 1
		get_tree().call_group('Player', 'change_can_move', false)
	else:
		self.visible = false
		finished = false
		
		dialog = ['que tu quer aqui dnv fdp',
		'larga da volta pnc'
		]
		
		if !root.story.has("talked"):
			root.story.append("talked")
			get_tree().call_group('hud', 'startTimer')
			get_tree().call_group('Life', 'changeVisible', true)
		dialog_index = 0
		
		get_tree().call_group('Player', 'change_can_move', true)


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	finished = true
