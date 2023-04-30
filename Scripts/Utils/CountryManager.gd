extends Node
class_name CountryManager


export (NodePath) var country_container_path = null
var country_container = null

var spawn_timer: Timer
export (float) var spawn_time: float = 7.5


# Set up
func _ready():
	randomize()

	country_container = get_node(country_container_path)
	instance_timer()


func instance_timer():
	spawn_timer = Timer.new()

	spawn_timer.wait_time = spawn_time
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", self, "spawn_timeout")

	add_child(spawn_timer)
	spawn_timer.start()



# Spawn a new plane after cooldown
func spawn_timeout():
	spawn_timer.start()
	country_container.spawn_plane()
