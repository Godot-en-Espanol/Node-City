extends TileMap


export var brick : PackedScene
var _used_tiles

onready var container = get_node("../YSort")

func _ready():
	_used_tiles = get_used_cells()
	spawn_bricks()

func spawn_bricks():
	for tile in _used_tiles:
		var _new_brick = brick.instance()
		container.add_child(_new_brick)
		_new_brick.global_position = map_to_world(tile) + Vector2(16, 16)
		set_cell(tile.x, tile.y, -1)
