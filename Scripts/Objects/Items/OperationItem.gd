extends Node2D


onready var main_item = get_parent()

onready var progress = $Operation_bar
onready var timer = $Timer

onready var spawn = $SFX/Spawn
onready var select = $SFX/Select
onready var click = $SFX/Click

var hovered: bool = false
var activated: bool = false

export (float) var time: float = 2.5
export (int) var removed_money: int = 50
export (int) var added_money: int = 100

export (Vector2) var interact_scale: Vector2 = Vector2(1.5, 1.5)


# Set up
func _ready():
	activated = false
	timer.wait_time = time
	timer.start()

	progress.max_value = timer.wait_time

	spawn.play()


# Run
func _process(delta):
	progress.value = timer.time_left

	if hovered == true and activated == false and Input.is_action_just_pressed("click"):
		activated = true
		timer.stop()

		main_item.money_manager.add_money(added_money)
		main_item.start_despawn()

		click.play()



# On timeout
func _on_Timer_timeout():
	main_item.money_manager.remove_money(removed_money)
	activated = true
	main_item.start_despawn()



# Interact
func _on_Operation_bar_mouse_entered():
	progress.rect_scale = interact_scale
	hovered = true

	select.play()


func _on_Operation_bar_mouse_exited():
	progress.rect_scale = Vector2(1, 1)
	hovered = false




