extends KinematicBody2D


onready var scale_tween = $Tween
onready var sprite = $Sprite

onready var hack_timer = $Hack_time
onready var notice = $Notice
onready var hack_bar = $Notice/Hack_bar

onready var popup = $Confirm

var country  = null
var target_pos: Vector2 = Vector2.ZERO

var velocity: Vector2
export (int) var speed: int = 150
export (float) var take_off_time: float = 5

export (int) var damage: int = 1
export (bool) var dangerous: bool = true

var selected: bool = false
var money_manager  = null
export (float) var hack_time: float = 4
export (int) var min_cost: int = 10
export (int) var max_cost: int = 25
var price: int


# Set up
func _ready():
	if is_instance_valid(country): target_pos = country.global_position

	sprite.scale = Vector2.ZERO
	take_off(Vector2.ZERO, Vector2(1,1))

	hack_timer.wait_time = hack_time
	hack_bar.max_value = hack_timer.wait_time
	price = rand_range(min_cost, max_cost)

	input_pickable = true
	notice.hide()
	popup.hide()



# Process
func _physics_process(delta):
	move_loop(delta)

func _process(delta):
	hacking_loop()


# Movement
func move_loop(delta):
	if is_instance_valid(country):
		look_at(target_pos)
		velocity += transform.x * speed

		velocity = move_and_slide(velocity * delta)

		var rounded_pos: Vector2 = global_position.round()
		if country.check_position(rounded_pos):
			if dangerous: destroy()
			else: queue_free()



# Damage country
func destroy():
	country.damage(damage)
	queue_free()



# Take off plane
func take_off(initial_scale: Vector2, final_scale: Vector2):
	scale_tween.interpolate_property(sprite, "scale", initial_scale, final_scale, take_off_time, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	scale_tween.start()



# Hacking the plane
func _on_Plane_mouse_entered():
	selected = true
	if dangerous: notice.show()

func _on_Plane_mouse_exited():
	selected = false


func hacking_loop():
	notice.global_rotation = 0
	hack_bar.value = hack_time - hack_timer.time_left

	if (dangerous and selected and Input.is_action_just_pressed("click")
	and hack_timer.is_stopped() and !(money_manager.money <= money_manager.min_money)):
		activate_popup(price)

func _on_Hack_time_timeout():
	dangerous = false
	notice.hide()


func activate_popup(price: int):
	popup.dialog_text = "Cost: " + str(price) + " / Current: " + str(money_manager.money)
	popup.popup()

func _on_Confirm_confirmed():
	money_manager.remove_money(price)
	hack_timer.start()



# Initialization
func initialize(country_obj, money):
	country = country_obj
	money_manager = money












