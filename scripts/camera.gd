extends Camera2D

var shake = 0.0
var dxy = Vector2(0, 0)
var smoothed = Vector2(0, 0)
var origin

func _ready() -> void:
	origin = position

func _process(_delta: float) -> void:
	dxy = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	smoothed += (dxy - smoothed) / 2
	position = origin + dxy
	if shake > 0:
		shake -= 0.1
