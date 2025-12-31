extends AudioStreamPlayer2D

var time = 0

func _process(_delta: float) -> void:
	time += _delta
	volume_db = -5 + clamp(25 * time, 0, 25)
