extends "res://Scene/UI/BaseUI.gd"

func _on_Restart_pressed() -> void:
	send_request(GameRequest.RESTART)
