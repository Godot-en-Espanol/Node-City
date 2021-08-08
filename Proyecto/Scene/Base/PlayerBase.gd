extends Area2D

signal base_destroyed

func _ready() -> void:
	connect("base_destroyed", GameManager, "_on_base_destroyed")


func _on_PlayerBase_area_entered(area: Area2D) -> void:
	emit_signal("base_destroyed")
	queue_free()
