extends Node

export var levels:Array
var current:Node2D


func load_stage(var number:int) -> void:
	assert(number <= levels.size(),"Stage %s doesn't exist" % number)
	var scene:PackedScene = levels[number]
	var scene_instance = scene.instance()
	if current:
		current.free()
	current = scene_instance
	add_child(current)
	GameManager.emit_signal("hide_ui")

func reload_current_stage():
	assert(current,"Stage wasn't loaded")
	load_stage(0)
	
	

