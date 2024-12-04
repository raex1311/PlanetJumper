extends Node2D

@export var normalfuel : GPUParticles2D
@export var boostedfuel : GPUParticles2D

var spaceship

func _ready() -> void:
	spaceship = get_node("../")
	spaceship.connect("startNormalJetfuel",NormalJetFuel)
	spaceship.connect("startBoostedJetfuel",BoostedJetFuel)
	NormalJetFuel()
	
func NormalJetFuel() -> void:
	normalfuel.show()
	boostedfuel.hide()
		
func BoostedJetFuel() -> void:
	normalfuel.hide()
	boostedfuel.show()
	
