class_name Tank
extends Area2D

signal tank_destroyed(tank_type)

export var bullet : PackedScene
export var hp := 1
export var movement_speed := 200.0
export var tank_type = "tank"

var speed := 0.0
var move_size : int
var tile_size : int
var moving := false
var current_direction := Vector2.ZERO setget change_direction
var _destroyed := false

onready var tween := $Tween
onready var collision_detector := $Body/CollisionDetector
onready var body := $Body
onready var bullet_position := $BulletPosition
onready var canon := $BulletPosition/Canon
onready var animation_tree := $AnimationPlayer/AnimationTree
onready var soud_manager:= $SoundManger

func _ready() -> void:
	tile_size = ProjectSettings.get("game_info/tile_size")
	# warning-ignore:integer_division
	GameManager.war_director.add_tank(self)
	randomize() 
	move_size = tile_size / 4
	_snap_position()

func _on_Tween_tween_all_completed() -> void:
	moving = false

func _snap_position() -> void:
	position = position.snapped(Vector2.ONE * move_size)

func _physics_process(_delta):
	if current_direction != Vector2.ZERO and !moving:
		move_foward()
	if speed == 0:
		$SoundManger/MovingStreamPlayer.stop()
	elif !$SoundManger/MovingStreamPlayer.playing:
		$SoundManger/MovingStreamPlayer.play()

func shoot() -> void:
	soud_manager.shoot()
	var _new_bullet = bullet.instance()
	_new_bullet.global_position = bullet_position.global_position
	_new_bullet.add_to_group(self.get_groups()[0])
	_new_bullet.init(current_direction, canon.position.y, self)
	get_parent().add_child(_new_bullet)


func change_direction(direction : Vector2) -> void:
	current_direction = direction
	if current_direction != Vector2.ZERO:
		body.look_at(body.global_position + current_direction)
		animation_tree.set("parameters/blend_position", current_direction)


func move_foward() -> void:
	if speed == 0.0:
		return
	
	if collision_detector.is_colliding():
		return
	
	moving = true
	
		
	var _time = move_size / speed
	var _new_position = position + current_direction * move_size
	
	tween.interpolate_property( self, "position",
								position, _new_position, _time)
	
	tween.start()
	return

func check_collision(_direction : Vector2) -> void:
	var _can_move := false
	body.look_at(body.global_position + _direction)

func destroy() -> void:
	if _destroyed:
		return
	queue_free()
	emit_signal("tank_destroyed", tank_type)
	_destroyed = true
