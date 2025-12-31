extends Area2D

@onready var area = $"."
@onready var game = %GameManager
var mouse = false

func _process(_delta: float) -> void:
	if game.no_stocks == 0:
		area.modulate = Color(0.8, 0.8, 0.8, 1)
	else:
		area.modulate = Color(1, 1, 1, 1)
	if mouse and game.no_stocks > 0:
		area.scale += (Vector2(1.2, 1.2) - area.scale) / 5
	else:
		area.scale += (Vector2(1, 1) - area.scale) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse:
		game.cookies += game.acc * game.no_stocks
		game.no_stocks = 0
		game.buy_cost = 0

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
