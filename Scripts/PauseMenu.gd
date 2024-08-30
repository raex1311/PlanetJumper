extends Node

var gameManager

func _ready() -> void:
	gameManager = get_node("../../")
	
func show_pauseMenu():
	get_node(".").visible = true
	gameManager.pause_game()

func hide_pauseMenu():
	get_node(".").visible = false
	gameManager.pause_game()
