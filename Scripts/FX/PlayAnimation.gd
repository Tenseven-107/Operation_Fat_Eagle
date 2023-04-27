extends AnimationPlayer


export (String) var on_awake_anim: String
export (bool) var destroy: bool

func _ready():
	play(on_awake_anim)


func _on_Overlay_anims_animation_finished(on_awake_anim):
	if destroy: queue_free()
