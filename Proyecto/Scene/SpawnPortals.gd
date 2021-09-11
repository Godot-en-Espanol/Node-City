extends Node2D

var _portals:Array

func _ready() -> void:
	_portals = get_children()

func get_random() -> Position2D:
	var random_index := randi() % _portals.size()
	return _portals[random_index]
