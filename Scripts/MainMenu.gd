extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var loadData = SaveAndLoad.Load_PlayerData()
	$PointLabel.text = str("Points: ",GlobalVariables.globalpoints)
	$HighScore.text = str("High Score: ", GlobalVariables.HighScore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
