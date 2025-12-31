extends Area2D

@onready var area = $"."
@onready var game = %GameManager
var mouse = false

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if mouse and game.cookies > 500:
		area.scale += (Vector2(1.1, 1.1) - area.scale) / 5
	else:
		area.scale += (Vector2(1, 1) - area.scale) / 5
	if game.cookies > 500:
		area.modulate = Color(1, 1, 1, 1)
	else:
		area.modulate = Color(0.8, 0.8, 0.8, 1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse and game.cookies > 500:
		var plus: RigidBody2D = load("res://scenes/plus.tscn").instantiate()
		plus.position = area.global_position + Vector2(randf_range(-2, 2), randf_range(-2, 2))
		plus.add_constant_force(Vector2(randf_range(-300, 300), 0))
		get_tree().current_scene.add_child(plus)
		game.comfort += 0.1
		game.cookies -= 500
		area.scale -= Vector2(0.1, 0.1)

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
