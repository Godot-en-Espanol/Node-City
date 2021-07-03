class_name Tank
extends Area2D

export var bullet : PackedScene
export var hp := 1
export var speed := 16.0

var move_size : int
var tile_size : int
var moving := false
var current_direction := Vector2.RIGHT

onready var tween := $Tween
onready var collision_detector := $Body/CollisionDetector
onready var body := $Body
onready var bullet_position := $BulletPosition
onready var canon := $BulletPosition/Canon
onready var animation_tree := $AnimationPlayer/AnimationTree

func _ready() -> void:
	tile_size = ProjectSettings.get("game_info/tile_size")
	move_size = tile_size / 4
	_snap_position()

func shoot() -> void:
	var _new_bullet = bullet.instance()
	_new_bullet.global_position = bullet_position.global_position
	_new_bullet.init(current_direction, canon.position.y)
	get_parent().add_child(_new_bullet)

func change_direction(direction : Vector2) -> void:
	print(direction)
	current_direction = direction
	_update_rotation()
	_update_animation()

func move_foward() -> void:
	if collision_detector.is_colliding():
		return
	
	moving = true
	
	var _time = move_size / speed
	var _new_position = position + current_direction * move_size
	
	tween.interpolate_property( self, "position",
								position, _new_position, _time)
	
	tween.start()

func _update_rotation() -> void:
	body.look_at(body.global_position + current_direction)

func _update_animation() -> void:
	animation_tree.set("parameters/blend_position", current_direction)

func _on_Tween_tween_all_completed() -> void:
	moving = false

func _snap_position() -> void:
	position = position.snapped(Vector2.ONE * move_size)
