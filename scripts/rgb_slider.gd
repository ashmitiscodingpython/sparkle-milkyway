extends Sprite2D

var mouse = false
var press = false
var value = 0
static var global_col = Color()
@export var rgb = "R"
@onready var game = %GameManager
@onready var area = $".."
@onready var parent = $"../.."

func _ready() -> void:
	area.position.x = 326

func _process(_delta: float) -> void:
	value = abs(1 - round(area.position.x + 326) / 652)
	var col = game.factory_color
	var mod = game.factory_color
	if rgb == "R":
		col.r = 1 - value
		mod.g = 0
		mod.b = 0
	elif rgb == "G":
		mod.r = 0
		col.g = 1 - value
		mod.b = 0
	elif rgb == "B":
		mod.r = 0
		mod.g = 0
		col.b = 1 - value
	game.factory_color = col
	if press:
		var limit_start = parent.global_position.x - 150
		var limit_end = parent.global_position.x + 150
		area.global_position.x = get_global_mouse_position().x
		area.global_position.x = clamp(get_global_mouse_position().x, limit_start, limit_end)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and mouse:
			press = true
		elif !event.pressed:
			press = false

func _on_area_2d_mouse_entered() -> void:
	mouse = true

func _on_area_2d_mouse_exited() -> void:
	mouse = false
