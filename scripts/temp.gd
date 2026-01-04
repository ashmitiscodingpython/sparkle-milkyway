extends VSlider

@onready var game = %GameManager
@onready var cookie = $"../Cookie"
var designated_x = 1107
var designated_size = 197
var valuex = 0
var cold_color = Color(0.576, 1, 0.458, 1)
var hot_color = Color(1, 0, 0.23, 1)
var lavaed = false

func _process(_delta: float) -> void:
	if game.lava:
		lavaed = true
	if lavaed:
		visible = true
	else:
		visible = false
	valuex = (cookie.boiling / 60) * 100
	if game.open:
		designated_x = 700
		designated_size = 320
	else:
		designated_x = 1107
		designated_size = 197
	self_modulate = lerp(cold_color, hot_color, valuex / 100.0)
	value = valuex
	position.x += (designated_x - position.x) / 5
	size.y += (designated_size - size.y) / 5
