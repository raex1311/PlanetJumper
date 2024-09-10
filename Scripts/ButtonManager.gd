extends Node2D

#==========References=====================
@export var spaceship : Node2D
@export var pauseMenu : Control

#==========Buttons========================
@export var ActivateShieldButton : Button
@export var SettingsButton : Button

func _ready() -> void:
	ActivateShieldButton.connect("pressed",spaceship.activate_Shield)
	SettingsButton.connect("pressed",OpenSettingsMenu)
	pass

func OpenSettingsMenu():
	pauseMenu.show_pauseMenu("SettingsMenu")
	
