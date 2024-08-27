extends Node2D

var gameManager : Node2D
var side = false
var is_active = false
var spaceship : Node2D

func _ready():
	gameManager = get_node("../")
	destroy_meteor()


func _process(delta):
	if(gameManager.game_is_over): return
	
	if(side==false):
		position.x -= 100 * delta
	else:
		position.x += 100 * delta

func _on_area_2d_body_entered(body):
	if body.is_in_group("spaceships"):
		spaceship = body
		if !body.shield_On:
			gameManager.GameOver()
		else:
			destroy_meteor()

func destroy_meteor():
	is_active = false
	visible = false
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	process_mode = Node.PROCESS_MODE_DISABLED
	
func initialize():
	is_active = true
	visible = true
	set_process(true)
	set_physics_process(true)
	set_process_input(true)	
	process_mode = Node.PROCESS_MODE_INHERIT
	var x = randf_range(0,2)
	if(int(x)==0):
		side = true
		spawn_left()
		print("Meteor Initialized Left!!")
		
	elif(int(x)==1):
		side = false
		spawn_right()
		print("Meteor Initialized Right!!")
		
	
	
func spawn_left():
	position.y = randf_range(0,800)
	position.x = randf_range(-1090,-1100)
	
func spawn_right():
	position.y = randf_range(0,800)
	position.x = randf_range(1090,1100)
