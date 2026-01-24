extends Area2D

var mouse = false
@onready var game = %GameManager
@onready var sprite = $"./Settings"

func _process(_delta: float) -> void:
	scale += (Vector2(1, 1) - scale) / 5
	if mouse:
		rotation_degrees += (90 - rotation_degrees) / 15
	else:
		rotation_degrees += (0 - rotation_degrees) / 15

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse:
		game.settings = true
		scale -= Vector2(0.5, 0.5)

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
