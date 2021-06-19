extends Area2D

export var bullet : PackedScene
export var hp := 1
export var speed := 80

const MOVE_SIZE := 8
const RAYCAST_SIZE := MOVE_SIZE - 1 + 32

var tile_size = 64
var moving := false

onready var body = $Body
onready var canon = $Body/Canon
onready var raycast_right = $Body/RayCastRight
onready var raycast_left = $Body/RayCastLeft

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	raycast_left.cast_to.y = -RAYCAST_SIZE
	raycast_right.cast_to.y = -RAYCAST_SIZE
	
func _physics_process(delta):
	var _x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var _y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if _x == 0 or _y == 0:
		body.look_at(global_position + Vector2(- _y, _x))
		if !moving:
			_move(Vector2(_x, _y))
	
	
	if Input.is_action_just_pressed("ui_accept"):
		var _new_bullet = bullet.instance()
		_new_bullet.global_position = canon.global_position
		_new_bullet.set_direction(position.direction_to(canon.global_position))
		get_parent().add_child(_new_bullet)

func _move(dir):
	if dir == Vector2.ZERO:
		return
	
	raycast_right.force_raycast_update()
	raycast_left.force_raycast_update()
	
	if raycast_right.is_colliding() or raycast_left.is_colliding(): 
		return
	
	moving = true
	
	var _time = MOVE_SIZE / speed
	var _new_position = position + dir * MOVE_SIZE
	
	$Tween.interpolate_property( self, "position",
								position, _new_position, _time,
								Tween.TRANS_LINEAR)
	
	$Tween.start()


func _on_Tween_tween_all_completed():
	moving = false
