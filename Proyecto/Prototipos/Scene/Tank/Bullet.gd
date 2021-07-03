extends Area2D

var direction := Vector2.RIGHT
var speed := 300.0

func init(_direction : Vector2) -> void:
	direction = _direction

func _physics_process(delta : float) -> void:
	global_position += direction * speed * delta

func _on_Bullet_body_entered(body):
	body.destroy()
	queue_free()
