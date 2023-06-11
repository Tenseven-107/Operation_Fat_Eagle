extends Node


onready var player = $Player
onready var volume_tween = $Tween

var tracks: Array = [
	preload("res://Audio/Music/460357__doctor_dreamchip__circuit-synthwave.wav"),
	preload("res://Audio/Music/457899__doctor_dreamchip__2018-09-05.mp3"),
	preload("res://Audio/Music/505283__carnotaurusteam__1-soundtrack.wav"),
	preload("res://Audio/Music/615546__projecteur__cosmic-dark-synthwave.mp3"),
]

var current_song: int = 0
var active: bool = true


func _ready():
	play_song(0)
	active = true

	player.volume_db = -80
	volume_tween.interpolate_property(player, "volume_db", -80, 0, 1.5, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	volume_tween.start()

	GlobalSignals.connect("game_over", self, "stop")



func play_song(song: int): 
		current_song = song

		player.stream = tracks[current_song]
		player.play()

func pick_new_song():
	var rand_number: int = rand_range(0, tracks.size())

	if rand_number != current_song:
		play_song(rand_number)
	else:
		pick_new_song()



func _on_Player_finished():
	if active: pick_new_song()


func stop():
	active = false
	player.stop()



