extends State

class_name Difficulty1


func Enter():
	print("Entered Difficulty 1")
	gameManager.set_speed(r_speed,d_speed)
	
func Update(delta):
	print("Updating Difficulty 1")
	
func Exit():
	print("Exiting Difficulty 1")
