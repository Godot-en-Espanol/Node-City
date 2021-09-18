class_name UIController
extends Control

export var menus:Array
var _menus_by_id:Dictionary
var _current_ui:BaseUI

func _ready() -> void:
	assert(menus.size()>0,"You must define one user interface at least")
	_callbacks()
	for menu in menus:
		var ui:BaseUI = menu.instance()
		ui.controller = self
		_menus_by_id[ui.name] = ui
	load_menu("SetupInitUI")

func _callbacks():
	GameManager.connect("player_loose",self,"load_menu",["LooseUI"])
	GameManager.connect("announce_wave",self,"load_menu",["WaveUI"])
	GameManager.connect("stage_cleared",self,"load_menu",["WinUI"])

func load_menu(var id:String):
	if _current_ui:
		remove_child(_current_ui)
	var menu:BaseUI = _menus_by_id[id]
	add_child(menu)
	menu.visible = true
	_current_ui = menu
