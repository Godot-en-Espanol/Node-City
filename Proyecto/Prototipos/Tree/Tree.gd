extends Area2D



func _on_Tree_area_entered(area):
	visible = false




func _on_Tree_area_exited(area):
	visible = true
