extends Area2D

var mouse = false
var inflate = false
@export var black = false
@export var factory = false
@export var shop = false
@export var settings = false
@onready var area = $"."
@onready var bla = $"../../Black Background"
@onready var game_manager = %GameManager
var norm = Vector2()

func _ready() -> void:
	norm = area.scale

func _process(_delta: float) -> void:
	if mouse:
		area.scale += ((norm * 1.2) - area.scale) / 5
	else:
		area.scale += (norm - area.scale) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if mouse:
			game_manager.facset = false
		elif mouse:
			game_manager.open = false
		elif mouse:
			game_manager.black = false
		elif mouse:
			game_manager.factory_color_prompt = false
		
func _on_mouse_entered() -> void:
	mouse = true
	game_manager.close_highlighted = true

func _on_mouse_exited() -> void:
	mouse = false
	game_manager.close_highlighted = false
