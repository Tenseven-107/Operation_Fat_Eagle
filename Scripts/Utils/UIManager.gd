extends Control


onready var money_meter = $Money_meter
onready var particle_container = $ParticleContainer
onready var tax_meter = $Tax_progress

onready var offshore_progress = $Interactables/Offshore_progress
onready var offshore_button = $Interactables/Offshore_progress/Offshore_button

onready var offshore_warning = $Popups/Offshore_warning
onready var offshore_buy = $Popups/Offshore_buy

onready var popup_audio = $Audio/Popup
onready var notification_audio = $Audio/Notification
onready var alert_audio = $Audio/Alert

onready var pause = $Pause

export (PackedScene) var dollar_fx: PackedScene
export (Vector2) var dollar_fx_pos: Vector2 = Vector2(129, 152)
onready var farm_audio = $Audio/Farm

export (NodePath) var money_manager_path = null
var money_manager: MoneyManager = null

export (NodePath) var op_manager_path = null
var op_manager: OPManager = null

export (int) var added_money: int = 1


# Set up and update ui
func _ready():
	money_manager = get_node(money_manager_path)
	op_manager = get_node(op_manager_path)

	tax_meter.max_value = money_manager.tax_time

func _process(delta):
	money_meter.value = money_manager.money
	tax_meter.value = money_manager.get_tax_time()

	if op_manager.is_time_stopped(): 
		offshore_button.show()
		offshore_progress.value = 0
	else:
		offshore_button.hide()
		offshore_progress.value = op_manager.get_upgrade_time()

	if Input.is_action_just_pressed("pause") && !pause.active: pause.activation(true)
	elif Input.is_action_just_pressed("pause") && pause.active: pause.activation(false)


# Add money when button is pressed
func _on_Farm_button_button_down():
	money_manager.add_money(added_money)

	var fx_inst = dollar_fx.instance()
	fx_inst.global_position = dollar_fx_pos
	particle_container.call_deferred("add_child", fx_inst)

	GlobalSignals.emit_signal("camera_shake", 100, 0.08, 300)
	GlobalSignals.emit_signal("camera_zoom", 0.9, 0.05, 0.9)
	GlobalSignals.emit_signal("hitstop", 0.05)

	farm_audio.play()



# Upgrade offshore operations
func _on_Offshore_button_pressed():
	if (op_manager.fully_upgraded or 
	(money_manager.money - op_manager.price) <= 0): 
		offshore_warning.popup()

		alert_audio.play()
	else:
		offshore_buy.dialog_text = ("Upgrade Offshore Operations: " + 
		"Cost: " + str(op_manager.price) + " / Current: " + str(money_manager.money) + 
		" / Current payday: " + str(op_manager.payout_money))

		offshore_buy.popup()

		popup_audio.play()



func _on_Offshore_buy_confirmed():
	op_manager.upgrade()

	notification_audio.play()



