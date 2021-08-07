extends Area2D

signal base_destroyed


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_PlayerBase_area_entered(area: Area2D) -> void:
	emit_signal("base_destroyed")
	queue_free()
