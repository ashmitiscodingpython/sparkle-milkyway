extends Sprite2D

@onready var game = %GameManager
var dx = 0

func _process(_delta: float) -> void:
	if game.open:
		dx = 63
	else:
		dx = 38.784375
	position.y += (dx - position.y) / 5
