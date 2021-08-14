extends "res://Scene/UI/BaseUI.gd"

func _on_Restart_pressed() -> void:
	emit_signal("game_request","restart")
