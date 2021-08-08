extends Node2D

var shoot_sound := [preload("res://SFX/Shoot/Disparo 3.ogg"),
					preload("res://SFX/Shoot/Disparo 4.ogg"),
					preload("res://SFX/Shoot/disparo Enemigo.ogg")]

var player_shoot_sound := [preload("res://SFX/Shoot/disparo player.ogg")]

onready var shoot_strem_player := $ShootStreamPlayer

func shoot() -> void:
	shoot_sound.shuffle()
	if owner.tank_type == "PlayerTank":
		shoot_strem_player.stream = player_shoot_sound[0]
	else:
		shoot_strem_player.stream = shoot_sound[0]
	shoot_strem_player.play()
