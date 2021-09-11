class_name BaseUI
extends Control

signal game_request(request)
signal next_window
var controller

func _ready() -> void:
	GameManager.connect("hide_ui",self,"hide")

func _enter_tree() -> void:
	assert(controller,"You must asing a controller")	
	assert(controller.has_method("_on_game_request"),"function _on_game_request is missing on controller")
	assert(controller.has_method("go_to"),"function go_to is missing on controller")
	connect("game_request",controller,"_on_game_request")

func _exit_tree() -> void:
	disconnect("game_request",controller,"_on_game_request")

func send_request(var request:String):
	emit_signal("game_request",request)

func go_next(var next_window:String):
	controller.go_to(next_window)

