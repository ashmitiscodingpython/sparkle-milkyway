extends Area2D

@onready var area = $"."
@onready var game = %GameManager
var mouse = false
var click = false

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var limit = -505.0
	if game.unlocked: limit = -800.0
	if mouse or click:
		area.scale += (Vector2(1.1, 1.1) - area.scale) / 5
		if click:
			var mousey = get_global_mouse_position().y
			if mousey < 97:
				mousey = 97
			elif mousey > 615:
				mousey = 615
			area.global_position.y = mousey
			game.shop_scroll = ((mousey - 97) / 518) * limit
	else:
		area.scale += (Vector2(1, 1) - area.scale) / 5
	area.position.y += ((-95 + ((game.shop_scroll / limit) * 221)) - area.position.y) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse:
		if event.pressed:
			click = true
		else:
			click = false
	elif event is InputEventMouseButton and !event.pressed:
		click = false

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
