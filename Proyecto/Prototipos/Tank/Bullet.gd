extends Area2D

var direction = Vector2.RIGHT
export var speed = 300

func set_direction(_direction):
	direction = _direction

func _physics_process(delta):
	global_position += direction * speed * delta



func _on_Bullet_body_entered(body):
	body.destroy()
	queue_free()
