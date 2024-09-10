extends RichTextLabel


# Variable to store the time elapsed
var time_elapsed : float = 0.0
var game_manager : Node2D
var Difficulty1 = false
var Difficulty2 = false
var Difficulty3 = false
@export var DifficultyLimit1 = 2
@export var DifficultyLimit2 = 4
@export var DifficultyLimit3 = 6
@export var FirebaseManager : Node2D
# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize the time_elapsed variable
	time_elapsed = 0.0
	# Set the initial text of the label to "Time elapsed: 0"
	text = "Time elapsed: 0"
	game_manager = get_node("../../../")
	game_manager.connect("GameIsOver", AddHighScore)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the time_elapsed variable
	time_elapsed += delta
	# Update the label text with the time elapsed as an integer
	text = "Time elapsed: " + str(int(time_elapsed))
	DifficultyChange()
	#AddHighScore()
		
func DifficultyChange():
		if(int(time_elapsed)==DifficultyLimit1 && Difficulty1==false):
			game_manager.Change_Difficulty(1)
			Difficulty1 = true
		elif(int(time_elapsed)==DifficultyLimit2 && Difficulty2==false):
			game_manager.Change_Difficulty(2)
			Difficulty2 = true
		elif(int(time_elapsed)==DifficultyLimit3 && Difficulty3==false):
			game_manager.Change_Difficulty(3)
			Difficulty3 = true

func AddHighScore():
	if(int(time_elapsed) > GlobalVariables.HighScore):
		print("Adding High Score!!")
		GlobalVariables.HighScore = int(time_elapsed)
		var type = SavingTypeList.new()
		type.type_list["HighScore"] = true
		SaveAndLoad.Save_PlayerData(type)
		FirebaseManager.fetch_my_score()
		
	
