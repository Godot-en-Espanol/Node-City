extends "res://Scene/UI/BaseUI.gd"

func _on_Start_pressed() -> void:
	emit_signal("game_request","start_game")

func _on_Options_pressed() -> void:
	emit_signal("game_request","load_options")

func _on_Exit_pressed() -> void:
	get_tree().quit()
