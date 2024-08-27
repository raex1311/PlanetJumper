extends Control



#========= Loading Data from files to GlobalData ========================
func _ready():
	SaveAndLoad.Load_PlayerData()
	$PointLabel.text = str("Points: ",GlobalVariables.globalpoints)
	$HighScore.text = str("High Score: ", GlobalVariables.HighScore)
	
	print("This is the end!!")
	if(SaveAndLoad.playerData.shieldTime!=null):
		GlobalVariables.Shield_Time = SaveAndLoad.playerData.shieldTime
	else:
		print("There is no any shield Time!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
