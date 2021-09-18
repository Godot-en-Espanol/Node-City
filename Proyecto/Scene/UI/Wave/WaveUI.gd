extends BaseUI

func _enter_tree() -> void:
	$Label.text = "Wave "+str(GameManager.war_director.get_wave_number())
