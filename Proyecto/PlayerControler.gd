extends TankControler

func _physics_process(_delta : float) -> void:
	var _direction : Vector2 
	
	_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if _direction and not(_direction.x and _direction.y):
		
		tank.change_direction(_direction) 
		
		if !tank.moving:
			tank.move_foward()
	
	if Input.is_action_just_pressed("ui_accept"):
		tank.shoot()
