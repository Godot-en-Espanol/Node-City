extends TankControler

var rng = RandomNumberGenerator.new()
export var min_time : float = 1.0
export var max_time : float = 2.0

onready var timer := $Timer

func _on_Timer_timeout():
	tank.shoot()
	rng.randomize()
	timer.wait_time = rng.randf_range(min_time, max_time)
	timer.start()
