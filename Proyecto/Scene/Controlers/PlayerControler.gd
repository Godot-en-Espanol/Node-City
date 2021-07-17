extends TankControler

var input_array := []

func _input(event : InputEvent):
	
	update_direction()
	
	if event.is_action_pressed("shoot"):
		tank.shoot()
		
func check_movement_input(input : String):
	if Input.is_action_just_pressed(input):
		if not input in input_array:
			input_array.append(input)
	if input in input_array and Input.is_action_just_released(input):
		input_array.remove(input_array.find(input))

func update_direction() -> void:
	
	var direction := Vector2.ZERO
	check_movement_input("move_up")
	check_movement_input("move_down")
	check_movement_input("move_left")
	check_movement_input("move_right")
	
	var last_action := ""
	if input_array.size() > 0:
		last_action = input_array[input_array.size()-1]
	
	tank.speed = tank.movement_speed
	match last_action:
		"move_down":
			direction = Vector2.DOWN
		"move_up":
			direction = Vector2.UP
		"move_left":
			direction = Vector2.LEFT
		"move_right":
			direction = Vector2.RIGHT
		_:
			tank.speed = 0
			
	if direction != Vector2.ZERO: 
		tank.current_direction = direction

