extends Node2D

class_name State

signal Transitioned
@export var next_state : String
@export var gameManager : Node2D
@export var r_speed : int
@export var d_speed : int


func Enter():
	pass

	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func GoNext():
	Transitioned.emit(self, next_state)
