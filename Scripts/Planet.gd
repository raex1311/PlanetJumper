extends Area2D
var speed = 0
var screen_size
var rotation_speed = 0
var game_Manager : Node2D


func _ready():
	game_Manager = get_node("../")
	screen_size = get_viewport_rect().size
	position.y = randf_range(-800,-1200)
	position.x = randf_range(-10,10)
	set_speed()
	game_Manager.settingSpeed.connect(set_speed)
	
	#linear_velocity = Vector2(0,speed)
	#set_angular_velocity(10)

func _process(delta):
	if(game_Manager.game_is_over):
		return
	position.y += speed * delta
	rotation_degrees += rotation_speed * delta
	if (position.y > screen_size.y):
		reset_position()
	   

func reset_position():
	position.y = randf_range(-800,-1200)
	position.x = randf_range(-450,450)

func change_rotation_values(downspeed: float,planet_rotation_speed : float):
	speed = downspeed
	rotation_speed = planet_rotation_speed
	pass
	
func set_speed():
	speed = game_Manager.downward_moving_speed
	rotation_speed = game_Manager.planet_rotation_speed

func randomizePlanet():
	pass
