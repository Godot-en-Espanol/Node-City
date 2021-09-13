extends TankControler

export var min_time : float = 1.5
export var max_time : float = 2.0

var rng = RandomNumberGenerator.new()
var _directions := [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

onready var timer := $Timer

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
	if posibles_directions.size() == 0:
		return Vector2.ZERO
	posibles_directions.shuffle()
	
	return posibles_directions[0]

func _on_Timer_timeout():
	tank.current_direction = _choose_new_direction()
	timer.start()
