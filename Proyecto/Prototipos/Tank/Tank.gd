extends Area2D

export var bullet : PackedScene
export var hp := 1
export var speed := 16.0

var move_size
var tile_size = 64
var moving := false


onready var collision_detector = $Body/CollisionDetector
onready var body = $Body
onready var canon = $Body/Canon
onready var animation_tree = $AnimationPlayer/AnimationTree

func _ready() -> void:
	tile_size = ProjectSettings.get("game_info/tile_size")
	move_size = tile_size / 4
	_snap_position()


func _physics_process(delta):
	
	var _direction : Vector2 
	
	_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	
	if _direction and not(_direction.x and _direction.y):
		
		body.look_at(global_position + _direction)
		animation_tree.set("parameters/blend_position", _direction)
		
		if !moving:
			_move(_direction)
	
	
	if Input.is_action_just_pressed("ui_accept"):
		var _new_bullet = bullet.instance()
		_new_bullet.global_position = canon.global_position
		_new_bullet.set_direction(_direction)
		get_parent().add_child(_new_bullet)

func _move(dir):
	if dir == Vector2.ZERO:
		return
	
	if collision_detector.is_colliding():
		return
	
	moving = true
	
	var _time = move_size / speed
	var _new_position = position + dir * move_size
	
	$Tween.interpolate_property( self, "position",
								position, _new_position, _time,
								Tween.TRANS_LINEAR)
	
	$Tween.start()

func _on_Tween_tween_all_completed():
	moving = false

func _snap_position() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
