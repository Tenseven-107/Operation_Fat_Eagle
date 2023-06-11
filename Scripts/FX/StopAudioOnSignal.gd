extends AudioStreamPlayer


export (String) var stop_signal: String = "game_over"

func _ready():
	GlobalSignals.connect(stop_signal, self, "stop")
