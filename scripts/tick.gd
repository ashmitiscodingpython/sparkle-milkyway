extends Area2D

@onready var area = $"."
@onready var game = %GameManager
var mouse = false

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if mouse:
		area.scale += (Vector2(1.1, 1.1) - area.scale) / 5
	else:
		area.scale += (Vector2(1, 1) - area.scale) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse:
		game.factory_color_prompt = false

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
