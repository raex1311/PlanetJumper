extends CharacterBody2D

var on_planet = true
var current_planet = null
var speed = 200
var landed = false
var circle_position: Vector2
var circle_radius: float
var onEarth = true
var shield_On = false
var shield : Node2D
var original_speed = 200
var Boost_Speed = 900
var gameManager
var gameOver = false
var Life : int = 2

func _ready():
	current_planet = get_node(".").get_parent()
	gameManager = get_node("../../")
	gameManager.connect("BoostSpeed",BoostSpaceship)
	shield = $Shield
	deactivate_Shield()
	gameManager.connect("GameIsOver", set_gameOver)

func set_gameOver():
	gameOver = true

func _physics_process(delta):
	if(gameOver): return
	if on_planet and current_planet:
		# Rotate with the planet
		
		#global_position = current_planet.global_position  +  current_planet.to_local(global_position).rotated(current_planet.angular_velocity * delta)
		if(landed):
			get_node(".").reparent(current_planet)
			#if(!onEarth):
				#position_tangent_to_circle()
			landed=false
		#current_planet.add_child(get_node("."))
	else:
		# Move upwards
		#velocity.y = -200
		var direction = Vector2(cos(rotation),sin(rotation))
		var rotated_direction = Vector2(-direction.y, direction.x)
		position -= rotated_direction * speed * delta
		#move_and_slide()

	# Check for leaving the planet
	if Input.is_action_just_pressed("leave_planet") and on_planet:
		on_planet = false
		onEarth = false
		if(current_planet!=null):
			get_node(".").reparent(current_planet.get_parent())
			_startJetFuel() #Starting Jet fuel when spaceship leaves the planet
		current_planet = null

func _rotateby180():
	rotation_degrees = rotation_degrees + 180
	
func position_tangent_to_circle():
	var collision_point = global_position
	var tangent_point = collision_point + (collision_point - circle_position).normalized() * circle_radius
	global_position = tangent_point
	#_rotateby180()
	
func set_spaceship_position(pos : Vector2, rot : float):
	global_position = pos
	global_rotation = rot

#=======================Booster========================
signal startLaser
signal stopLaser

func BoostSpaceship():
	speed = Boost_Speed
	_startBoostedJetfuel()
	startLaser.emit()
	
func StopBoostSpaceship():
	speed = original_speed
	_stopJetFuel() #Stopping the jetfuel when landed
	_startNormalJetfuel() #setting jetfuel to normal
	stopLaser.emit()
#===========================================================
func activate_Shield():
	if(shield_On): return
	shield_On = true
	shield.visible = true
	var timer = $ShieldTimer
	print("Shield Time::" , GlobalVariables.Shield_Time)
	timer.wait_time = GlobalVariables.Shield_Time
	print("Shield Timer: ", GlobalVariables.Shield_Time)
	timer.start()
	
	
func deactivate_Shield():
	shield_On = false
	shield.visible = false
	
#==================LIFE======================================
func DeductLife():
	print("Deducted Life!!:--", Life)
	if Life == 1:
		gameManager.GameOver()
	elif Life > 1 :
		Life = Life - 1
		
#================JETFUEL====================================
signal startJetFuel
signal stopJetFuel
signal startNormalJetfuel
signal startBoostedJetfuel

func _startJetFuel():
	startJetFuel.emit()
	
func _stopJetFuel():
	stopJetFuel.emit()
	
func _startNormalJetfuel():
	startNormalJetfuel.emit()
	
func _startBoostedJetfuel():
	startBoostedJetfuel.emit()
