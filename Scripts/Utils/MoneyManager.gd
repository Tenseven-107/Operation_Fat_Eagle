extends Node
class_name MoneyManager


var money: int = 0
export (int) var min_money: int = -200
export (int) var max_money: int = 200

var tax_timer: Timer
export (int) var tax_money: int = 10
export (float) var tax_time: float = 5


# set up
func _ready():
	instance_timer()

func instance_timer():
	tax_timer = Timer.new()

	tax_timer.wait_time = tax_time
	tax_timer.one_shot = true
	tax_timer.connect("timeout", self, "tax_timeout")

	add_child(tax_timer)
	tax_timer.start()


# Add and deplete money
func add_money(added_money: int):
	money += added_money
	money = clamp(money, min_money, max_money)

func remove_money(removed_money: int):
	money -= removed_money
	money = clamp(money, min_money, max_money)

func get_tax_time():
	return tax_timer.time_left


func tax_timeout():
	tax_timer.start()
	remove_money(tax_money)

