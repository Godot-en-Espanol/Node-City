extends Node

var _stage_config:Resource
onready var _destroyed_tanks :=0
var _current_wave := 0
export var peace_time:=5

signal start_wave


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_stage(spawner):
	connect("start_wave",spawner,"start_wave")
	_stage_config = spawner.stage_config
	_current_wave = 0
	_next_wave()

func add_tank(tank:Tank):
	tank.connect("tank_destroyed", self, "_on_tank_detroyed")

func _next_wave():
	_current_wave += 1
	_destroyed_tanks = 0
	GameManager.emit_signal("announce_wave")
	yield(get_tree().create_timer(peace_time), "timeout")
	GameManager.emit_signal("hide_ui")
	emit_signal("start_wave")

func _on_tank_detroyed(tank_type : String):
	match tank_type:
		"PlayerTank":
			print("hey")
			GameManager.emit_signal("player_loose")
		"BasicEnemy":
			_destroyed_tanks +=1
			if _destroyed_tanks == _stage_config.tanks_per_wave:
				if _current_wave < _stage_config.number_of_waves:
					_next_wave()
				else:
					GameManager.emit_signal("stage_cleared")

func get_wave_number() ->int:
	return _current_wave
