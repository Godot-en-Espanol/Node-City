extends Node2D

func _ready():
	update_ray_size()

func update_ray_size() -> void:
	var move_size = ProjectSettings.get("game_info/tile_size") / 4
	
	for ray in get_children():
		ray.cast_to.x = move_size - 1

func is_colliding() -> bool:
	for ray in get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			return true
	return false
