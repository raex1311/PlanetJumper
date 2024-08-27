extends Node

var playerData = PlayerData.new()
var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"

func _ready():
		verify_save_directory(save_file_path)
		
#===============SAVE and LOAD DATA====================
func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)
	
func Load_PlayerData():
	if(!FileAccess.file_exists(save_file_path + save_file_name)): return
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	GlobalVariables.globalpoints = playerData.points
	GlobalVariables.HighScore = playerData.highscore
	print("Points Loaded: ", playerData.points)
	
func Save_PlayerData(saveType : GlobalVariables.SaveType):
	
	match saveType:
		GlobalVariables.SaveType.Points:
			playerData.change_points(GlobalVariables.globalpoints)
		GlobalVariables.SaveType.HighScore:
			playerData.change_highscore(GlobalVariables.HighScore)
		GlobalVariables.SaveType.ShieldTime:
			playerData.change_shieldtime()
	ResourceSaver.save(playerData,save_file_path + save_file_name)
	
	

#=====================================================
