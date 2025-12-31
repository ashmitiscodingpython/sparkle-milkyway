extends Area2D

@onready var area = $"."
@onready var game = %GameManager
var mouse = false

func _process(_delta: float) -> void:
	if game.cookies > game.acc:
		area.modulate = Color(1, 1, 1, 1)
		if mouse:
			area.scale += (Vector2(1.2, 1.2) - area.scale) / 5
		else:
			area.scale += (Vector2(1, 1) - area.scale) / 5
	else:
		area.modulate = Color(0.8, 0.8, 0.8, 1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse and event.pressed:
		if game.cookies > game.acc:
			game.cookies -= game.acc
			game.no_stocks += 1
			game.buy_cost += game.acc
			area.scale -= Vector2(0.1, 0.1)

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
