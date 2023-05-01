extends Node2D


export (PackedScene) var plane = preload("res://Prefabs/Objects/Plane.tscn")
var plane_container = null
var money_manager = null

onready var progress = $HP_bar

export (int) var max_hp: int = 2
var hp: int = 2

var this_pos: Vector2 = Vector2.ZERO
var min_pos: Vector2
var max_pos: Vector2

export (Array, NodePath) var countries


# Set up
func _ready():
	this_pos = global_position.round()
	min_pos = Vector2(this_pos.x + 3, this_pos.y + 3)
	max_pos = Vector2(this_pos.x + 3, this_pos.y + 3)



# Spawn a plane
func spawn_plane():
	var plane_inst = plane.instance()

	plane_inst.global_position = global_position
	plane_inst.initialize(get_random_country(), money_manager)

	plane_container.add_child(plane_inst)



# Take damage
func damage(damage: int):
	hp -= damage
	progress.value = hp

	if hp <= 0:
		print("Hit!") # testing
		pass # put stuff later

	GlobalSignals.emit_signal("camera_shake", 200, 0.1, 400)
	GlobalSignals.emit_signal("hitstop", 0.1)


# Compare pos
func check_position(pos: Vector2):
	if pos == this_pos or (pos >= min_pos and pos <= max_pos):
		return true

	else: return false



# Get a random country from assosciated countries
func get_random_country():
	var max_number = countries.size()
	var picked_num = rand_range(0, max_number)
	var country = get_node(countries[picked_num])

	return country



# Initialization
func initialize(plane_cont: Node, money: Node):
	plane_container = plane_cont
	money_manager = money





