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


func _ready():
	take_off(Vector2.ZERO, Vector2(1,1))


func _physics_process(delta):
	if is_instance_valid(country):
		target_pos = country.global_position

		look_at(target_pos)
		velocity += transform.x * speed

		if country.check_position(global_position) and dangerous: destroy()
		elif country.check_position(global_position): queue_free()

		velocity = move_and_slide(velocity * delta)


func destroy():
	country.damage(damage)
	queue_free()


func take_off(initial_scale: Vector2, final_scale: Vector2):
	scale_tween.interpolate_property(sprite, "scale", initial_scale, final_scale, take_off_time, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	scale_tween.start()



