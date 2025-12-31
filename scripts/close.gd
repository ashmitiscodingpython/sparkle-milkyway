extends Area2D

var mouse = false
var inflate = false
@export var black = false
@export var factory = false
@export var color = false
@onready var area = $"."
@onready var bla = $"../../Black Background"
@onready var game_manager = %GameManager

func _process(_delta: float) -> void:
	if mouse:
		if !factory:
			var scaled = (1 - area.scale.x) / 5
			area.scale += Vector2(scaled, scaled)
		elif !color:
			area.scale += (Vector2(0.86, -1.199) - area.scale) / 5
		elif color:
			area.scale += (Vector2(0.7728, -1.0776) - area.scale) / 5
	else:
		if !factory:
			var scaled = (0.8 - area.scale.x) / 5
			area.scale += Vector2(scaled, scaled)
		elif !color:
			area.scale += (Vector2(0.67, -0.934) - area.scale) / 5
		elif color:
			area.scale += (Vector2(0.644, -0.898) - area.scale) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if mouse and factory and !color:
			game_manager.facset = false
		elif mouse and !black and !color:
			game_manager.open = false
		elif mouse and black:
			game_manager.black = false
		elif mouse and color:
			game_manager.factory_color_prompt = false
		
func _on_mouse_entered() -> void:
	mouse = true
	game_manager.close_highlighted = true

func _on_mouse_exited() -> void:
	mouse = false
	game_manager.close_highlighted = false
