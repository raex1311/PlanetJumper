extends Area2D

var body_has_entered = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("spaceships"):
		if(body_has_entered):
			var Gamemanager = get_node("../../")
			Gamemanager.add_point()
			body_has_entered = false
		body.on_planet = true
		body.current_planet = get_parent()
		body.landed = true
		body.circle_position = global_position
		body.circle_radius = $CollisionShape2D.shape.radius
		body.set_spaceship_position(get_child(1).global_position,get_child(1).global_rotation)

