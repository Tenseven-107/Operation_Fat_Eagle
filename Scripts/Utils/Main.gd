extends Node2D


onready var money_manager = get_node("UI/MoneyManager")
onready var country_container = get_node("Map/Country_container")


func _ready():
	country_container.initialize(money_manager)
