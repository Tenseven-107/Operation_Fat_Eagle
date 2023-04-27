extends Control


onready var money_meter = $Money_meter
onready var tax_meter = $Tax_progress

export (NodePath) var money_manager_path = null
var money_manager: MoneyManager = null

export (int) var added_money: int = 1


func _ready():
	money_manager = get_node(money_manager_path)
	tax_meter.max_value = money_manager.tax_time

func _process(delta):
	money_meter.value = money_manager.money
	tax_meter.value = money_manager.get_tax_time()


func _on_Farm_button_pressed():
	money_manager.add_money(added_money)
