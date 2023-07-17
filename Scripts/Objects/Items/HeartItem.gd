extends Node2D


onready var main_item = get_parent()

onready var particles = $Particles
onready var sprite = $Sprite

onready var spawn = $SFX/Spawn
onready var select = $SFX/Select
onready var click = $SFX/Click

var hovered: bool = false
var activated: bool = false

export (float) var time: float = 2.5
export (int) var added_hp: int = 1
export (int) var added_money: int = 10

export (Vector2) var interact_scale: Vector2 = Vector2(1.5, 1.5)


# Set up
func _ready():
	activated = false

	spawn.play()


# Run
func _process(delta):
	if hovered == true and activated == false  and Input.is_action_just_pressed("click"):
		activated = true
		main_item.country.heal(added_hp)
		main_item.money_manager.add_money(added_money)

		sprite.hide()
		particles.emitting = true
		click.play()


# Interact
func _on_Sprite_mouse_entered():
	sprite.rect_scale = interact_scale
	hovered = true

	select.play()


func _on_Sprite_mouse_exited():
	sprite.rect_scale = Vector2(1, 1)
	hovered = false



