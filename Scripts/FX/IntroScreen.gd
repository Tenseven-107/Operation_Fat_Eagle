extends Control

export (PackedScene) var change_to_scene: PackedScene = preload("res://Scenes/Main.tscn")
onready var anims = $Anims


# Starting
func _ready():
	anims.play("Intro")
	SaveState.load_game(false)

func start_game():
	get_tree().change_scene_to(change_to_scene)


# Set fullscreen
func load_save_stats(stats):
	OS.window_fullscreen = stats.options.fullscreen
