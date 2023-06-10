extends CanvasLayer


onready var anims = $Control/Overlay_anims

var game_over: bool = false

func _ready():
	game_over = false

	GlobalSignals.connect("country_hit", self, "play_rumble")
	GlobalSignals.connect("game_over", self, "play_game_over")


func play_rumble():
	if !game_over: anims.play("Hit")

func play_game_over():
	game_over = true
	anims.play("Game_over")
