extends Node2D

class_name State

signal Transitioned
@export var next_state : String
@export var gameManager : Node2D
@export var r_speed : int
@export var d_speed : int
@export var MeteorManager : Node2D
@export var min_meteor_Timer : float
@export var max_meteor_Timer : float


func Enter():
	gameManager.set_speed(r_speed,d_speed)
	MeteorManager.min_meteor_Timer = min_meteor_Timer
	MeteorManager.max_meteor_Timer = max_meteor_Timer
	MeteorManager.change_meteor_timer()
	pass

	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func GoNext():
	Transitioned.emit(self, next_state)
	
	
