extends Node2D

# Reference to the Line2D and RayCast2D nodes
@onready var line: Line2D = $Line2D
@onready var raycast: RayCast2D = $RayCast2D

var laser_status = false
# Maximum length of the laser
var max_length: float = 1000.0
var spaceship

func _ready() -> void:
	# Set the initial length of the laser
	print("Laser is started!!")
	spaceship = get_node("../")
	spaceship.connect("stopLaser",Stop_Laser)
	spaceship.connect("startLaser",Start_Laser)
	#update_laser()

func _process(delta: float) -> void:
	# Update the laser every frame
	if(!laser_status): return
	update_laser()

func update_laser() -> void:
	# Set the ray's cast_to property to the max length
	raycast.target_position = Vector2(max_length, 0)
	
	# Force ray to update its collision
	raycast.force_raycast_update()

	if raycast.is_colliding():
		# If the ray collides with something, shorten the laser
		var collision_point: Vector2 = raycast.get_collision_point()
		line.points = [Vector2.ZERO, line.to_local(collision_point)]
	else:
		# If the ray doesn't collide, set the laser to its full length
		line.points = [Vector2.ZERO, Vector2(max_length, 0)]

func Start_Laser():
	laser_status = true
	
func Stop_Laser():
	print("Stopping Laser!!!!!")
	laser_status = false
	line.points = [Vector2.ZERO, Vector2.ZERO]

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left mouse button clicked")
			#Start_Laser()
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			print("Right mouse button clicked")
			#Stop_Laser()
