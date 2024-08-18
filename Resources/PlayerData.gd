# PlayerData.gd
extends Resource
class_name PlayerData

@export var points : int
@export var highscore : int

func change_points(point : int):
	points = point

func change_highscore(score : int):
	highscore = score
