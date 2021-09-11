extends "res://Scene/UI/BaseUI.gd"

func _on_Start_pressed() -> void:
	send_request(GameRequest.START_GAME)

func _on_Options_pressed() -> void:
	go_next("load_options")

func _on_Exit_pressed() -> void:
	get_tree().quit()
