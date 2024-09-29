extends Area2D

@export var myside : bool

func _ready() -> void:
	print("Detecting Meteor Crash!!")
	
	
func _on_body2d_Enter(body : Area2D):
	var meteor = body.get_parent()
	if(meteor.side == myside):
		meteor.destroy_meteor()
		
