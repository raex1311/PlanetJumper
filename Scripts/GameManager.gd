extends Node2D

@export var falling_object_scene : PackedScene 
@export var meteor : PackedScene
@export var timer : Timer
var gap_percentage = 10
var meteorCount = 10
var meteorPool = []
var planet_count = 0
var planet_points = 0

var point_label

#Global Variable
#--------------------
var planet_rotation_speed : float = 100
var downward_moving_speed : float = 100
var game_is_over = false
#--------------------


func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_Timer_timeout)
	point_label = $GameHUD/Points/RichTextLabel
	Add_meteor_to_pool()
	#spawn_Planet() #------ Needed for Spawing the Planets -----#
	
func _on_Timer_timeout():
	spawn_meteor()
	
func spawn_Planet():
	var gap = 0
	for i in range(10):
		planet_count+=1
		var falling_object = falling_object_scene.instantiate()
		add_child(falling_object)
		var screen_size = get_viewport_rect().size
		falling_object.position = Vector2(randf_range(-450,450), randf_range(-(screen_size.y/gap_percentage) - 200 - gap,-(screen_size.y/gap_percentage)- 400 - gap))
		gap+=400
		
func spawn_meteor():
	var meteor = get_meteor()
	meteor.initialize()

func add_point():
	planet_points += 1
	point_label.text = str("Points: ",planet_points)
	GlobalVariables.add_point()
	var type = SavingTypeList.new()
	type.type_list["Points"] = true
	SaveAndLoad.Save_PlayerData(type)
	
func Use_Boosters():
	if(GlobalVariables.Boosters == 0):
		print("Not Enough Boosters To use!!")
		$PauseMenu.show_pauseMenu("NotEnoughCoins")
		return
	
	print("Boosters USED!!")
	GlobalVariables.deduct_Boosters()
	var type = SavingTypeList.new()
	type.type_list["Points"] = true
	type.type_list["Boosters"] = true
	SaveAndLoad.Save_PlayerData(type)
	BoostSpeed.emit()

	
	
func Goto_MainMenu():
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
#SIGNALS
#============================
signal startingGame
signal pausingGame
signal stoppingGame
signal GameIsOver
signal settingSpeed
signal BoostSpeed
#============================
func start_game():
	startingGame.emit()
	
func set_speed(r_speed: float, d_speed : float):
	planet_rotation_speed = r_speed
	downward_moving_speed = d_speed
	settingSpeed.emit()

func stop_game():
	stoppingGame.emit()

func pause_game():
	pausingGame.emit()
	onPause()
	
func onPause():
	if get_tree().paused:
		get_tree().paused = false  # Unpause the game
	else:
		get_tree().paused = true  # Pause the game
	
func GameOver():
	print("Game Over!!")
	game_is_over = true
	$GameOverScreen.visible = true
	GameIsOver.emit()

#================= Meteor pooling========================
func Add_meteor_to_pool():
	for i in range(meteorCount):
		var meteor = meteor.instantiate()
		add_child(meteor)
		meteorPool.append(meteor)
		
func get_meteor():
	for meteor in meteorPool:
		if not meteor.is_active:
			return meteor
#========================================================
