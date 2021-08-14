extends Node

export var levels_path:NodePath
var level_manager
signal hide_ui
signal game_event(event)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_manager = get_node_or_null(levels_path)
	assert(level_manager,"Level Manager missing")

func _on_tank_detroyed(tank_type : String):
	match tank_type:
		"PlayerTank":
			print("hey")
			emit_signal("game_event","player_loose")

func _on_base_destroyed():
	emit_signal("game_event","player_loose")

func run(var name:String):
	match name:
		"start_game":
			level_manager.load_stage(0) #Placeholder
			emit_signal("hide_ui")
		"restart":
			level_manager.reload_current_stage()
