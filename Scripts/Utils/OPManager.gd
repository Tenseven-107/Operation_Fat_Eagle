extends Node
class_name OPManager


export (NodePath) var money_manager_path = null
var money_manager: MoneyManager = null

var payout_timer: Timer
export (float) var payout_time: float = 15
var upgrade_timer: Timer
export (float) var upgrade_time: float = 20

var payout_money: int = 0
export (int) var max_payout_money: int = 20
var fully_upgraded: bool = false

var price: int = 5
export (int) var added_price: int = 5


# set up
func _ready():
	money_manager = get_node(money_manager_path)
	instance_timers()

func instance_timers():
	payout_timer = Timer.new()
	upgrade_timer = Timer.new()

	payout_timer.wait_time = payout_time
	payout_timer.one_shot = true
	payout_timer.connect("timeout", self, "payday")

	upgrade_timer.wait_time = upgrade_time
	upgrade_timer.one_shot = true

	add_child(payout_timer)
	add_child(upgrade_timer)
	payout_timer.start()



# Upgrade
func upgrade():
	if upgrade_timer.is_stopped() and !fully_upgraded and !((money_manager.money - price) <= 0):
		payout_money += 1

		money_manager.remove_money(price)
		price += added_price

		upgrade_timer.start()

		if payout_money >= max_payout_money:
			fully_upgraded = true


# Payout
func payday():
	payout_timer.start()
	money_manager.add_money(payout_money)



# Get upgrade time
func get_upgrade_time():
	return upgrade_timer.time_left

func is_time_stopped():
	return upgrade_timer.is_stopped()










