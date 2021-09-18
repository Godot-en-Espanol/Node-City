extends Area2D

signal base_destroyed

func _on_PlayerBase_area_entered(area: Area2D) -> void:
	GameManager.emit_signal("player_loose")
	queue_free()
