extends Control


onready var risk_label = $Sheet/Risk
onready var high_risk_label = $Sheet/HighRisk

export (NodePath) var menu_path: NodePath
var menu = null

var active: bool = false


# set up
func _ready():
	active = false

	menu = get_node(menu_path)
	menu.hide()
	hide()

	GlobalSignals.connect("game_over", self, "set_active")


# Menu activity
func set_active():
	active = true
	show()


func _process(delta):
	if active and Input.is_action_just_pressed("click"):
		menu.show()

		risk_label.text = String(TempMemory.get_risk_levels()[0])
		high_risk_label.text = String(TempMemory.get_risk_levels()[1])



# Buttons
func _on_Retry_pressed():
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	get_tree().quit()






