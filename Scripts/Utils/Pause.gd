extends Control


onready var quit = $Items/VBoxContainer/Quit
onready var fullscreen = $Items/VBoxContainer/Fullscreen_check
onready var music = $Items/VBoxContainer/Music_slider
onready var sfx = $Items/VBoxContainer/SFX_slider
onready var master_ = $Items/VBoxContainer/Master_slider

onready var tween = $Tween

var active: bool = false


# Activation
func _ready():
	active = false
	hide()

	self.modulate = Color.transparent

	set_options()

func activation(set_active: bool):
	if set_active:
		get_tree().paused = true
		active = true
		show()

		tween.interpolate_property(self, "modulate", Color.transparent, Color.white, 0.5, 
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
	else:
		get_tree().paused = false
		active = false

		tween.interpolate_property(self, "modulate", Color.white, Color.transparent, 0.5, 
		Tween.TRANS_LINEAR)
		tween.start()

func _on_Tween_tween_all_completed():
	if !active: hide()



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


# Music volume
func _on_Music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)


# SFX volume
func _on_SFX_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)


# Master volume
func _on_Master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


