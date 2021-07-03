extends TileMap

export var brick : PackedScene
export var container_path : NodePath

onready var container := get_node(container_path)

func _ready() -> void:
	spawn_bricks()

func spawn_bricks() -> void:
	for tile in get_used_cells():
		var _new_brick := brick.instance()
		container.add_child(_new_brick)
		_new_brick.global_position = map_to_world(tile) + Vector2(16, 16)
		set_cell(tile.x, tile.y, -1)
