extends VBoxContainer

signal load_menu(menu)

func _on_Start_pressed() -> void:
	emit_signal("load_menu","start")


func _on_Options_pressed() -> void:
	emit_signal("load_menu","options")


func _on_Exit_pressed() -> void:
	get_tree().quit()
