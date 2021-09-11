class_name UIController
extends Control

export var menus:Array
var _menus_by_id:Dictionary
var _current_ui:BaseUI

func _ready() -> void:
	assert(menus.size()>0,"You must define one user interface at least")
	GameManager.connect("game_event",self,"_on_game_event")
	for menu in menus:
		var ui:BaseUI = menu.instance()
		ui.controller = self
		_menus_by_id[ui.name] = ui
	_load_menu("SetupInitUI")

func _on_game_request(var request:String) -> void:
	if request.begins_with("load"):
		pass
	else:
		GameManager.run(request)

func _on_game_event(var event:String) -> void:
	match event:
		"player_loose":
			_load_menu("LooseUI")

func _load_menu(var id:String):
	if _current_ui:
		remove_child(_current_ui)
	var menu:BaseUI = _menus_by_id[id]
	add_child(menu)
	menu.visible = true
	_current_ui = menu

func go_to(var next:String) -> void:
	pass
