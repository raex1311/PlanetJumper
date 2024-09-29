extends Node2D

var gameManager : Node2D
@export var meteor : PackedScene
var side = false
var is_active = false
var spaceship : Node2D
var meteorCount = 10
var meteorPool = []
var timer : Timer
var min_meteor_Timer : float = 10
var max_meteor_Timer : float = 20
var meteorSpawned : bool

func _ready():
	gameManager = get_node("../")
	Add_meteor_to_pool()
	timer = $M_Timer as Timer
	timer.timeout.connect(_on_Timer_timeout)
	change_meteor_timer()
	print("Meteor Manager Loaded----------------------")
	

func change_meteor_timer():
	if(timer):
		timer.wait_time = randf_range(min_meteor_Timer,max_meteor_Timer)
	

func _on_Timer_timeout():
	spawn_meteor()
	
func spawn_meteor():
	print("Spawning Meteor!!---------------------")
	var meteor = get_meteor()
	if(!meteor): return
	meteor.initialize()

#region Meteor Pooling
#================= Meteor pooling========================
func Add_meteor_to_pool():
	for i in range(meteorCount):
		var meteor = meteor.instantiate()
		add_child(meteor)
		meteorPool.append(meteor)
	meteorSpawned = true
		
func get_meteor():
	if(meteorPool.size() > 0):
		for meteor in meteorPool:
			if not meteor.is_active:
				return meteor

func send_meteorBackToPool(meteor : Node2D):
	meteorPool.append(meteor)
#========================================================
#endregion
