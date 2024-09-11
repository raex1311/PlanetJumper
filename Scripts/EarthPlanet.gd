extends Area2D
var speed = 100
var rotation_speed = 1


	
	
	#linear_velocity = Vector2(0,speed)
	#set_angular_velocity(10)

func _process(delta):
	position.y += speed * delta
	rotation_degrees += rotation_speed * delta

func on_spaceship_exit(body : Node):
	print("Earth Exited~~-----------------------------------------------")
	if body.is_in_group("spaceships"):
		DestroyEarth()
		
		
func DestroyEarth():
	print("Earth Destroyed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	self.visible = false
