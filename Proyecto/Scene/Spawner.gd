class_name Spawner
extends YSort

export var spawn_portals_path:NodePath
export var tank_scene:PackedScene
export(Resource) var stage_config
export(int,1,10) var spawn_frequency := 2

var _spawn_portals
var _spawned_tanks := 0

signal wave_spawned 
onready var _spawn_timer = $Timer

func _ready() -> void:
	_spawn_portals = get_node_or_null(spawn_portals_path)
	GameManager.war_director.set_stage(self)

func start_wave():
	_spawned_tanks = 0
	_spawn_timer.start(spawn_frequency)

func _on_Timer_timeout() -> void:
	_spawn()
	if _spawned_tanks == stage_config.tanks_per_wave:
		_spawn_timer.stop()
		emit_signal("wave_spawned")

func _spawn() -> void:
	var instance_position:Position2D = _spawn_portals.get_random()
	var tank:Tank = tank_scene.instance()
	add_child(tank)
	tank.position = instance_position.position
	_spawned_tanks += 1
