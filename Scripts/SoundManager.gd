extends Node

@onready var music_player = $MusicPlayer
@onready var sfx_player = $SFXPlayer

@export var Jump : AudioStream
@export var GameManager : Node2D

var music_volume := 1.0
var sfx_volume := 1.0

func _ready():
	music_player.volume_db = linear_to_db(music_volume)
	sfx_player.volume_db = linear_to_db(sfx_volume)
	GameManager.connect("LandedOnPlanet",LandPlanetSound)
	

func play_music(stream: AudioStream, loop: bool = true):
	music_player.stream = stream
	music_player.loop = loop
	music_player.play()

func stop_music():
	music_player.stop()

func play_sfx(stream: AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

func set_music_volume(vol: float):
	music_volume = clamp(vol, 0.0, 1.0)
	music_player.volume_db = linear_to_db(music_volume)

func set_sfx_volume(vol: float):
	sfx_volume = clamp(vol, 0.0, 1.0)
	sfx_player.volume_db = linear_to_db(sfx_volume)
	
func LandPlanetSound():
	play_sfx(Jump)
