extends Area2D
var speed = 100
var rotation_speed = 1


	
	
	#linear_velocity = Vector2(0,speed)
	#set_angular_velocity(10)

func _process(delta):
	position.y += speed * delta
	rotation_degrees += rotation_speed * delta
