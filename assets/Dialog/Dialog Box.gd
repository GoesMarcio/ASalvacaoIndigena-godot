extends Control

var dialog = [
	'oien',
	'fala tu padrinho',
	'qual a boa do find meu cpx',
	'satisfacao afu cpx'
]

var dialog_index = 0
var finished = false

func _ready() -> void:
	load_dialog()
	
func _process(delta: float) -> void:
	$"next-phase".visible = finished
	if Input.is_action_just_pressed("space"):
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
	else:
		self.visible = false
		finished = false
		
		dialog = ['que tu quer aqui dnv fdp',
		'larga da volta pnc'
		]
		dialog_index = 0


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	finished = true
