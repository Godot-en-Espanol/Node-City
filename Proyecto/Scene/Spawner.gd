extends Node2D

export var spawn_portals_path:NodePath
export var spawn_root_path:NodePath
export var tank_scene:PackedScene
export(int,1,7) var number_of_waves := 1
export(int,1,10) var tanks_per_wave := 1
export(int,1,10) var spawn_frequency := 1

var _spawn_root
var _spawn_portals
var _spawned_tanks := 0
var _current_wave := 1
onready var _spawn_timer = $Timer

func _ready() -> void:
	_spawn_portals = get_node_or_null(spawn_portals_path)
	_spawn_root = get_node_or_null(spawn_root_path)
	_spawn_timer.start(spawn_frequency)

func _on_Timer_timeout() -> void:
	_spawn()
	if _spawned_tanks == tanks_per_wave:
		_spawn_timer.stop()
		_spawned_tanks = 0
		_current_wave += 1

func _spawn() -> void:
	var instance_position:Position2D = _spawn_portals.get_random()
	var tank:Tank = tank_scene.instance()
	_spawn_root.add_child(tank)
	tank.position = instance_position.position
	_spawned_tanks += 1



