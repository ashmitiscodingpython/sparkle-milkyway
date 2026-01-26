extends Sprite2D

var engaged = true
var touchtime = 0
var last = 0

func _process(_delta: float) -> void:
	if touchtime != last:
		engaged = true
	else:
		engaged = false
	last = touchtime
	if !engaged:
		texture = null
	position = get_global_mouse_position()
