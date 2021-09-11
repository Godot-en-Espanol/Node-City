extends Node2D

export var spawn_portals_path:NodePath
export var spawn_root_path:NodePath
var _spawn_root
var _spawn_portals
export var tank_scene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_portals = get_node_or_null(spawn_portals_path)
	_spawn_root = get_node_or_null(spawn_root_path)

func _on_Timer_timeout() -> void:
	var instance_position:Position2D = _spawn_portals.get_random()
	var tank:Tank = tank_scene.instance()
	_spawn_root.add_child(tank)
	tank.position = instance_position.position
	
