extends Area2D

export var move_size := 8
export var bullet : PackedScene

var tile_size = 64
var moving := false
onready var ray = $RayCast2D

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	move_size = tile_size/4

func _physics_process(delta):
	var _dir = Vector2.ZERO
	
	if not moving:
		if Input.is_action_pressed("ui_right"):
			_move(Vector2.RIGHT)
			$icon.rotation_degrees = 90
		if Input.is_action_pressed("ui_left"):
			_move(Vector2.LEFT)
			$icon.rotation_degrees = -90
		if Input.is_action_pressed("ui_down"):
			_move(Vector2.DOWN)
			$icon.rotation_degrees = 180
		if Input.is_action_pressed("ui_up"):
			_move(Vector2.UP)
			$icon.rotation_degrees = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		var _new_bullet = bullet.instance()
		_new_bullet.global_position = $icon/Canon.global_position
		_new_bullet.set_direction(position.direction_to($icon/Canon.global_position))
		get_parent().add_child(_new_bullet)

func _move(dir):
	ray.cast_to = dir * 32
	ray.force_raycast_update()
	
	if ray.is_colliding(): 
		return
	moving = true
	var _time = 0.2
	var _new_position = position + dir * move_size
	
	$Tween.interpolate_property( self, "position",
								position, _new_position, _time,
								Tween.TRANS_LINEAR)
	
	$Tween.start()
	yield($Tween, "tween_completed")
	moving = false
