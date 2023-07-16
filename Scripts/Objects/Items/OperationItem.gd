extends Node2D


onready var progress = $Operation_bar
onready var timer = $Timer

var activated: bool = false

export (float) var time: float = 2.5
export (int) var removed_money: int = 25


# Set up
func _ready():
	activated = false
	timer.wait_time = time
	timer.start()

	
