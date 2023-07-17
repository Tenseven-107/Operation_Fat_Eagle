extends Node2D


export (NodePath) var plane_container_path = null
export (NodePath) var item_container_path = null
var plane_container = null
var item_container = null
var money_manager = null

var children: Array

export (Array, PackedScene) var items


# Set up
func set_up():
	plane_container = get_node(plane_container_path)
	item_container = get_node(item_container_path)

	children = get_children()
	for child in children:
		child.initialize(plane_container, item_container, money_manager)


# Spawn a new plane from a country
func spawn_plane():
	var max_country = children.size()
	var picked_num = rand_range(0, max_country)
	var country = children[picked_num]

	country.spawn_plane()


# Spawn a new plane from a country
func spawn_item():
	var max_country = children.size()
	var picked_num = rand_range(0, max_country)

	var max_item = items.size()
	var picked_item = items[rand_range(0, max_item)]

	var country = children[picked_num]
	country.spawn_item(picked_item)


# Initialization
func initialize(money: Node):
	money_manager = money

	set_up()





