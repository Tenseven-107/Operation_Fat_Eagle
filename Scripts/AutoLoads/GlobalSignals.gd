extends Node


# Gameplay
signal country_hit()
signal game_over()

# FX signals
signal camera_shake(new_shake, shake_time, shake_limit)
signal camera_zoom(new_zoom, zoom_time, zoom_limit)
signal hitstop(time)
