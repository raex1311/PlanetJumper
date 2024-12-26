extends Control



#========= Loading Data from files to GlobalData ========================
func _ready():
	SaveAndLoad.Load_PlayerData()
	Refresh_Stored_Data()
	SaveAndLoad.DataIsSaving.connect(Refresh_Stored_Data)

func Refresh_Stored_Data():
	$Panel/ColorRect/PointLabel.text = str("Points: ",GlobalVariables.globalpoints)
	$Panel/ColorRect/HighScore.text = str("High Score: ", GlobalVariables.HighScore)
	if(SaveAndLoad.playerData.shieldTime!=null):
		print("Shield Time: ", SaveAndLoad.playerData.shieldTime)
		GlobalVariables.Shield_Time = SaveAndLoad.playerData.shieldTime
	else:
		print("There is no any shield Time!!")
		
	if(SaveAndLoad.playerData.Boosters!=null):
		print("The Booster: ", SaveAndLoad.playerData.Boosters)
		GlobalVariables.Shield_Time = SaveAndLoad.playerData.Boosters
	else:
		print("There is no any boosters!!")
	$Panel/ColorRect/"Booster Points".text = str("Booster Points: ",GlobalVariables.Boosters)

	
func start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	SaveAndLoad.DataIsSaving.disconnect(Refresh_Stored_Data)
