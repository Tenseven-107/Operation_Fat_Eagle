extends KinematicBody2D


onready var scale_tween = $Tween
onready var sprite = $Sprite

var country  = null
var target_pos: Vector2 = Vector2.ZERO


var velocity: Vector2
export (int) var speed: int = 150
export (float) var take_off_time: float = 5

export (int) var damage: int = 1
export (bool) var dangerous: bool = true



# Set up
func _ready():
	if is_instance_valid(country): target_pos = country.global_position

	sprite.scale = Vector2.ZERO
	take_off(Vector2.ZERO, Vector2(1,1))



# Process
func _physics_process(delta):
	move_loop(delta)


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



