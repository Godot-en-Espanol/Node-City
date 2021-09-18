extends "res://Scene/UI/BaseUI.gd"

func _on_Restart_pressed() -> void:
	GameManager.level_manager.reload_current_stage()
