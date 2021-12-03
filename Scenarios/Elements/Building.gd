extends StaticBody2D

signal player_enter(building)

func _on_Door_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("player_enter", 1)
