extends Node2D

@export var normalfuel : GPUParticles2D
@export var boostedfuel : GPUParticles2D

var spaceship

func _ready() -> void:
	print("Jet fuel script started!!")
	spaceship = get_node("../")
	spaceship.connect("startNormalJetfuel",NormalJetFuel)
	spaceship.connect("startBoostedJetfuel",BoostedJetFuel)
	spaceship.connect("startJetFuel",StartJetFuel)
	spaceship.connect("stopJetFuel",StopJetFuel)
	NormalJetFuel()
	StopJetFuel()
	
func NormalJetFuel() -> void:
	print("Normal Jet Fuel")
	normalfuel.show()
	boostedfuel.hide()
		
func BoostedJetFuel() -> void:
	print("Boosted Jet Fuel")
	normalfuel.hide()
	boostedfuel.show()
	
func StopJetFuel():
	normalfuel.emitting = false
	boostedfuel.emitting = false
	self.hide()
	
func StartJetFuel():
	self.show()
	normalfuel.emitting = true
	boostedfuel.emitting = true
	
