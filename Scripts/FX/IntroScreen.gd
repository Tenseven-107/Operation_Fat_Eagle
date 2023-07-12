extends Control

export (PackedScene) var change_to_scene: PackedScene = preload("res://Scenes/Main.tscn")
onready var anims = $Anims


func _ready():
	anims.play("Intro")

func start_game():
	get_tree().change_scene_to(change_to_scene)
