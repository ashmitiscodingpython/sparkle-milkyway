extends Sprite2D

var mouse = false
@export var ear_id = 0
@onready var sprite = $"."
@onready var game = %GameManager

func _process(_delta: float) -> void:
	var dif = global_position - get_global_mouse_position()
	mouse = sqrt(pow(dif.x, 2) + pow(dif.y, 2)) < 25
	if mouse:
		if ear_id == 1:
			game.rightear = true
		else:
			game.leftear = true
		if !game.lava:
			sprite.texture = load("res://images/closeear.png")
		else:
			sprite.texture = load("res://images/levaearclosed.png")
	else:
		if ear_id == 1:
			game.rightear = false
		else:
			game.leftear = false
		if !game.lava:
			sprite.texture = load("res://images/ear.png")
		else:
			sprite.texture = load("res://images/levaear.png")
