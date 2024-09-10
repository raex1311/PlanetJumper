extends Node

var playerData = PlayerData.new()
var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"

signal DataIsSaving


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
	GlobalVariables.Boosters = playerData.Boosters
	print("Points Loaded: ", playerData.points)
	
func Save_PlayerData(saveTypeList : SavingTypeList):
	var reverse_dict = {}
	var allKeys = saveTypeList.type_list.keys()
	for x in allKeys:
		if(saveTypeList.type_list[x] == true):
			print("True:->", x)
			update(x)
	ResourceSaver.save(playerData,save_file_path + save_file_name)
	DataIsSaving.emit()
	
func update(saveType: String):
	match saveType:
		"Points":
			playerData.change_points(GlobalVariables.globalpoints)
			print("Changing Points!")
		"HighScore":
			playerData.change_highscore(GlobalVariables.HighScore)
			print("Changing HighScore")
		"ShieldTime":
			playerData.change_shieldtime()
			print("Changing ShieldTime!!")
		"Boosters":
			playerData.change_boosters(GlobalVariables.Boosters)
			print("Adding Boosters!!")

#=====================================================
