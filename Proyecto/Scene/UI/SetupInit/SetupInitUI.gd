extends "res://Scene/UI/BaseUI.gd"

func _on_Start_pressed() -> void:
	GameManager.level_manager.load_stage(0) #Placeholder

func _on_Options_pressed() -> void:
	controller.load_menu("load_options")

func _on_Exit_pressed() -> void:
	get_tree().quit()
