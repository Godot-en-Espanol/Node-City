class_name BaseUI
extends Control

var controller

func _ready() -> void:
	GameManager.connect("hide_ui",self,"hide")

func _enter_tree() -> void:
	assert(controller,"You must asing a controller")
