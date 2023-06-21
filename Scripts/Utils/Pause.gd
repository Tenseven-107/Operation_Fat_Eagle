extends Control


onready var quit = $Items/VBoxContainer/Quit
onready var fullscreen = $Items/VBoxContainer/Fullscreen_check
onready var music = $Items/VBoxContainer/Music_slider
onready var sfx = $Items/VBoxContainer/SFX_slider
onready var master_ = $Items/VBoxContainer/Master_slider

onready var music_audio = $Audio/Music_audio
onready var sfx_audio = $Audio/SFX_audio
onready var master_audio = $Audio/Master_audio
onready var fullscreen_audio = $Audio/Fullscreen_audio
onready var hover_audio = $Audio/Hover_audio

onready var tween = $Tween

var active: bool = false
var can_be_active: bool = true


# Activation
func _ready():
	active = false
	can_be_active = true
	hide()

	self.modulate = Color.transparent

	set_options()

	GlobalSignals.connect("game_over", self, "set_unactive")

func activation(set_active: bool):
	if can_be_active:
		if set_active:
			get_tree().paused = true
			active = true
			show()

			tween.interpolate_property(self, "modulate", Color.transparent, Color.white, 0.5, 
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			tween.start()

			music.grab_focus()
		else:
			get_tree().paused = false
			active = false

			tween.interpolate_property(self, "modulate", Color.white, Color.transparent, 0.5, 
			Tween.TRANS_LINEAR)
			tween.start()

func _on_Tween_tween_all_completed():
	if !active: hide()

func set_unactive():
	can_be_active = false


# Setting the options accordingly
func set_options():
	fullscreen = OS.window_fullscreen
	music.value = AudioServer.get_bus_volume_db(1)
	sfx.value = AudioServer.get_bus_volume_db(2)
	master_.value = AudioServer.get_bus_volume_db(0)


# Quit
func _on_Quit_button_up():
	get_tree().quit()


# Fullscreen
func _on_Fullscreen_check_toggled(button_pressed: bool):
	OS.window_fullscreen = button_pressed
	if active: fullscreen_audio.play()


# Music volume
func _on_Music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	if active: music_audio.play()


# SFX volume
func _on_SFX_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
	if active: sfx_audio.play()


# Master volume
func _on_Master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	if active: master_audio.play()


# Hover buttons
func _on_Quit_focus_entered():
	hover_audio.play()

func _on_Quit_mouse_entered():
	hover_audio.play()


func _on_Fullscreen_check_focus_entered():
	hover_audio.play()

func _on_Fullscreen_check_mouse_entered():
	hover_audio.play()


func _on_Music_slider_focus_entered():
	hover_audio.play()

func _on_Music_slider_mouse_entered():
	hover_audio.play()


func _on_SFX_slider_focus_entered():
	hover_audio.play()

func _on_SFX_slider_mouse_entered():
	hover_audio.play()


func _on_Master_slider_focus_entered():
	hover_audio.play()

func _on_Master_slider_mouse_entered():
	hover_audio.play()
