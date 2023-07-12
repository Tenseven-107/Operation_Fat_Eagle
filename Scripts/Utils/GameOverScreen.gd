extends Control


onready var risk_label = $Sheet/Risk
onready var high_risk_label = $Sheet/HighRisk
onready var anims = $Anims

onready var press_audio = $Audio/Press_audio
onready var hover_audio = $Audio/Hover_audio

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

	anims.play("default")


# Menu activity
func set_active():
	active = true
	show()

	SaveState.save_game(false)


func _process(delta):
	if active and Input.is_action_just_pressed("click") and menu.visible == false:
		menu.show()
		anims.play("popup")

		risk_label.text = String(TempMemory.get_risk_levels()[0])
		high_risk_label.text = String(TempMemory.get_risk_levels()[1])



# Buttons
func _on_Retry_pressed():
	press_audio.play()
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	press_audio.play()
	get_tree().quit()


func _on_Retry_mouse_entered():
	hover_audio.play()


func _on_Quit_mouse_entered():
	hover_audio.play()


func _on_Retry_focus_entered():
	hover_audio.play()


func _on_Quit_focus_entered():
	hover_audio.play()
