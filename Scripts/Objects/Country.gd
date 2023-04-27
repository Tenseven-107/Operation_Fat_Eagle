extends Node2D


export (PackedScene) var plane = preload("res://Prefabs/Objects/Plane.tscn")
var plane_container = null

onready var progress = $HP_bar

export (int) var max_hp: int = 2
var hp: int = 2

export (Array, NodePath) var countries


func spawn_plane():
	var plane_inst = plane.instance()

	plane_inst.global_position = global_position
	plane_inst.target_pos = get_random_country()

	plane_container.add_child(plane_inst)


func damage(damage: int):
	hp -= damage
	progress.value = hp

	if hp <= 0:
		print("Hit!") # testing
		pass # put stuff later


func check_position(pos: Vector2):
	if pos == self.global_position: return true
	else: return false


func get_random_country():
	var max_number = countries.size()
	var picked_num = rand_range(0, max_number)
	var country = get_node(countries[picked_num])

	return country


func initialize(plane_cont: Node):
	plane_container = plane_cont


