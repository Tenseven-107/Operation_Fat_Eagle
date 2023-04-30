extends CPUParticles2D


export (bool) var on_awake: bool = true
export (bool) var destroy_on_end: bool = true


func _ready():
	if on_awake: emitting = true

func _on_Timer_timeout():
	if destroy_on_end: queue_free()
