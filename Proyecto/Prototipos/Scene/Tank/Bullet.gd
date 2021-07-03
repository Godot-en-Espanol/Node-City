extends Area2D

var _direction := Vector2.ZERO
var _sprite_offset : float
var speed := 300.0

var initialized := false

onready var sprite := $Sprite


func _ready():
	
	assert(initialized, "You need to initialize the bullet with `init()` before adding to tree.")
	sprite.position.y = _sprite_offset

func _physics_process(delta : float) -> void:
	global_position += _direction * speed * delta


func _on_Bullet_body_entered(body):
	body.destroy()
	queue_free()


func init(direction : Vector2, sprite_offset : float) -> void:
	_direction = direction
	_sprite_offset = sprite_offset
	initialized = true


