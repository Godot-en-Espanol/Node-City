extends Area2D

var direction := Vector2.ZERO
var sprite_offset : float
var speed := 300.0
var shooter

var initialized := false

onready var sprite := $Sprite


func _ready() -> void:
	assert(initialized, "You need to initialize the bullet with `init()` before adding to tree.")
	sprite.position.y = sprite_offset

func init(_direction : Vector2, _sprite_offset : float, _shooter) -> void:
	if _direction == Vector2.ZERO:
		_direction = Vector2.RIGHT
	direction = _direction
	sprite_offset = _sprite_offset
	shooter = _shooter
	initialized = true

func _physics_process(delta : float) -> void:
	global_position += direction * speed * delta

func _on_Bullet_body_entered(body) -> void:
	if body.has_method("destroy"):
		body.destroy()
	queue_free()

func _on_Bullet_area_entered(area) -> void:
	if area == shooter: 
		return
	if area.has_method("destroy") and area.get_groups()[0] != get_groups()[0]:
		area.destroy()
		queue_free()
