extends Node

signal hide_ui

signal player_loose
signal restart
signal start_game
signal announce_wave
signal stage_cleared

onready var level_manager = $LevelManager
onready var war_director = $WarDirector
