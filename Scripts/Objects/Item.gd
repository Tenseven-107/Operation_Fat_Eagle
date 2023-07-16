extends Node2D
class_name Item


var despawn_timer = null
var tween = null

var country = null
var money_manager = null

export (float) var despawn_time: float = 3
var active: bool = false



# Set up
func _ready():
	active = false
	instance_objects()


# Add objects needed
func instance_objects():
	# Add timer
	despawn_timer = Timer.new()

	despawn_timer.wait_time = despawn_time
	despawn_timer.one_shot = true
	despawn_timer.connect("timeout", self, "start_despawn")

	add_child(despawn_timer)
	despawn_timer.start()

	# Add tween
	tween = Tween.new()
	add_child(tween)

	tween.connect("tween_all_completed", self, "despawn")

	tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(1, 1), despawn_time  / despawn_time, 
	Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	tween.start()



# Despawn
func start_despawn():
	active = true

	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2.ZERO, despawn_time  / despawn_time, 
	Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	tween.start()

func despawn():
	if active == true:
		call_deferred("queue_free")




# Initialization
func initialize(country: Node, money: Node):
	country = country
	money_manager = money



