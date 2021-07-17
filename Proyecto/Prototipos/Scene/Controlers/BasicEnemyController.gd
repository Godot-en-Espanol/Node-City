extends TankControler

var _directions := [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

func _ready() -> void:
	yield(tank,"ready")
	tank.collision_detector.connect("collided", self, "_on_collision_detector_collided")
	tank.speed = tank.movement_speed
	tank.current_direction = _choose_new_direction()

func _on_collision_detector_collided() -> void:
	tank.current_direction = _choose_new_direction()

func _choose_new_direction()-> Vector2:
	var posibles_directions := []
	
	for direction in _directions:
		if not tank.collision_detector.is_colliding(direction):
			posibles_directions.append(direction)
	
	posibles_directions.shuffle()
	
	return posibles_directions[0]
	
