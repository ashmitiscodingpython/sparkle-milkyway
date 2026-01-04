extends Sprite2D

@onready var game = %GameManager
var dx = 0

func _process(_delta: float) -> void:
	if game.open:
		dx = 73
	else:
		dx = 44.94062499999999
	position.y += (dx - position.y) / 5
