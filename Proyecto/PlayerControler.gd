extends TankControler

func _physics_process(_delta : float) -> void:
	var _direction : Vector2 
	
	_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if _direction and not(_direction.x and _direction.y):
		
		tank.current_direction = _direction
		
		tank.body.look_at(tank.body.global_position + _direction)
		tank.animation_tree.set("parameters/blend_position", _direction)
		
		if !tank.moving:
			tank._move(_direction)
	
	if Input.is_action_just_pressed("ui_accept"):
		tank.shoot()
