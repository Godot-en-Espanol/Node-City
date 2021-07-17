extends Node2D

signal collided

func _ready() -> void:
	update_ray_size()

func update_ray_size() -> void:
	var move_size : int = ProjectSettings.get("game_info/tile_size") / 4

	for ray in get_children():
		ray.cast_to.x = move_size - 1

func is_colliding(direction := Vector2.ZERO) -> bool:
	var is_colliding := false
	
	if direction != Vector2.ZERO:
		global_rotation = direction.angle()
	
	for ray in get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			is_colliding = true
	
	rotation = 0
	
	if is_colliding and direction == Vector2.ZERO:
		emit_signal("collided")
	
	return is_colliding
