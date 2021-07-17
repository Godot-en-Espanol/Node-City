extends StaticBody2D

var life := 2

func destroy() -> void:
	life -= 1
	
	if life <= 0:
		queue_free()
	else:
		$Node2D.modulate += Color(1,1,1)
