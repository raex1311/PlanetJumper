# PlayerData.gd
extends Resource
class_name PlayerData

@export var points : int
@export var highscore : int
@export var shieldTime : int
@export var Boosters : int
@export var SFXVolume : float
@export var MusicVolume : float

func change_points(point : int):
	points = point

func change_highscore(score : int):
	highscore = score

func change_shieldtime():
	shieldTime = shieldTime + 1

func change_boosters(booster : int):
	Boosters = booster
	
func change_music(volume :float):
	MusicVolume = volume
	
func change_Sfx(volume : float):
	SFXVolume = volume
