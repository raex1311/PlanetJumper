extends RayCast2D

var is_casting: bool = false:
	set = set_is_casting

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	set_physics_process(is_casting)
	if(is_casting):
		appear()
	else:
		disappear()
	
func _ready()-> void:
	set_physics_process(false)
	if $Line2D.get_point_count() < 2:
		$Line2D.add_point(Vector2.ZERO)  # Add a default point if the array is empty.
		$Line2D.add_point(Vector2.ZERO)
		$Line2D.set_point_position(1,Vector2.ZERO)
	
func _physics_process(delta: float) -> void :
	var cast_point := target_position
	force_raycast_update()
	if is_colliding():
		cast_point = to_local(get_collision_point())
	if $Line2D.get_point_count() < 2:
		$Line2D.add_point(Vector2.ZERO)  # Add a default point if the array is empty.
		$Line2D.add_point(Vector2.ZERO)
	$Line2D.set_point_position(1,target_position)

		
func appear():
	print("Appear!!")
	var tween = create_tween()
	tween.stop()
	tween.tween_property($Line2D,"width",0,1000)
	tween.play()

func disappear():
	print("Disappear!!")
	var tween = create_tween()
	tween.stop()
	tween.tween_property($Line2D,"width",1000,0)
	tween.play()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left mouse button clicked")
			self.is_casting = event.pressed
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			print("Right mouse button clicked")
