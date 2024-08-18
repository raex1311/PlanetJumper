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

func _ready():
	current_planet = get_node(".").get_parent()
	shield = $Shield
	deactivate_Shield()

func _physics_process(delta):
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

func activate_Shield():
	if(shield_On): return
	print("Shield Activated!!")
	shield_On = true
	shield.visible = true
	var timer = $ShieldTimer
	timer.start()
	
	
func deactivate_Shield():
	print("Shield Deactivated!!")
	shield_On = false
	shield.visible = false
