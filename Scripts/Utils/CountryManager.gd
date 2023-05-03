extends Node
class_name CountryManager


export (NodePath) var country_container_path = null
var country_container = null

var spawn_timer: Timer
var current_spawn_time: float
export (float) var max_spawn_time: float = 20
export (float) var min_spawn_time: float = 5

var risk: float = 0
export (float) var risk_increase: float = 0.001


# Set up
func _ready():
	randomize()

	country_container = get_node(country_container_path)
	instance_timer()


func instance_timer():
	spawn_timer = Timer.new()

	current_spawn_time = max_spawn_time
	spawn_timer.wait_time = current_spawn_time
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", self, "spawn_timeout")

	add_child(spawn_timer)
	spawn_timer.start()



# Spawn a new plane after cooldown
func spawn_timeout():
	increase_risk()

	spawn_timer.start()
	country_container.spawn_plane()



# Increase risk level
func increase_risk():
	risk += risk_increase

	if current_spawn_time > min_spawn_time:
		current_spawn_time -= risk
		current_spawn_time = clamp(current_spawn_time, min_spawn_time, max_spawn_time)

		spawn_timer.wait_time = current_spawn_time






