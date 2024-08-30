extends Node

var globalpoints : int
var HighScore : int
var Shield_Time : int

func add_point():
	globalpoints = 1 + globalpoints
	
func add_custom_points(points: int):
	globalpoints = globalpoints + points

func deduct_point(points_to_deduct:int):
	print("Points to deduct!!")
	globalpoints = globalpoints - points_to_deduct

func add_ShieldTime():
	Shield_Time = Shield_Time + 1
