extends Control


onready var money_meter = $Money_meter
onready var particle_container = $ParticleContainer
onready var tax_meter = $Tax_progress

export (PackedScene) var dollar_fx: PackedScene
export (Vector2) var dollar_fx_pos: Vector2 = Vector2(129, 152)
onready var farm_audio = $Audio/farm

export (NodePath) var money_manager_path = null
var money_manager: MoneyManager = null

export (int) var added_money: int = 1


# Set up and update ui
func _ready():
	money_manager = get_node(money_manager_path)
	tax_meter.max_value = money_manager.tax_time

func _process(delta):
	money_meter.value = money_manager.money
	tax_meter.value = money_manager.get_tax_time()


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
