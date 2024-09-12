extends Node

var gameManager

func _ready() -> void:
	gameManager = get_node("../")
	hide_subMenu()
	
func show_pauseMenu(menuType : String):
	get_node(".").visible = true
	show_subMenu(menuType)
	gameManager.pause_game()

func hide_pauseMenu():
	get_node(".").visible = false
	hide_subMenu()
	gameManager.pause_game()

func show_subMenu(menuType: String):
	match menuType:
		"NotEnoughCoins":
			$"Not Enough Coins".visible = true
		"SettingsMenu":
			$"Settings Menu".visible = true
	pass
	
func hide_subMenu():
	$"Not Enough Coins".visible = false
	$"Settings Menu".visible = false
