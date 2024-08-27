extends Node

var globalpoints : int
var HighScore : int
var Shield_Time : int

func add_point():
	globalpoints = 1 + globalpoints

func deduct_point(points_to_deduct:int):
	globalpoints = globalpoints - points_to_deduct

func add_ShieldTime():
	Shield_Time = Shield_Time + 1

enum SaveType {
	Points,
	HighScore,
	ShieldTime
}
