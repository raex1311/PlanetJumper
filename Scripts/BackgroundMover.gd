extends Node2D

@export var BG1 : Sprite2D
@export var BG2 : Sprite2D
@export var BG3 : Sprite2D
var background_height: float
var game_Manager

var speed = 100

func _ready():
	game_Manager = get_node("../")
	background_height = BG1.texture.get_size().y
	BG2.position.y = BG1.position.y - background_height
	BG3.position.y = BG2.position.y - background_height
	game_Manager.settingSpeed.connect(changespeed)

func _process(delta):
	if(game_Manager.game_is_over):
		return
	BG1.position.y += speed * delta
	BG2.position.y += speed * delta
	BG3.position.y += speed * delta
	
	if(BG1.position.y > get_viewport().size.y + background_height):
		BG1.position.y = BG3.position.y - background_height
	
	if(BG2.position.y > get_viewport().size.y + background_height):
		BG2.position.y = BG1.position.y - background_height
		
	if(BG3.position.y > get_viewport().size.y + background_height):
		BG3.position.y = BG2.position.y - background_height

func changespeed():
	speed = game_Manager.downward_moving_speed
