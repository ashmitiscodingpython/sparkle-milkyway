extends Sprite2D

@onready var parent = $".."
@onready var game = $"../../GameManager"
var mouse = false
var pressed = false
var elapse = 0
var afterelapse = 0

func _ready() -> void:
	parent.position = Vector2(randi_range(0, 1150), 734)

func _process(_delta: float) -> void:
	parent.position.y -= 2
	if elapse > 30:
		game.golde = false
		pressed = false
		afterelapse += _delta
	if afterelapse >= 5:
		queue_free()
	if !pressed:
		if mouse:
			parent.scale += (Vector2(1.3, 1.3) - parent.scale) / 5
		else:
			parent.scale += (Vector2(1, 1) - parent.scale) / 5
	else:
		elapse += _delta
		parent.position += (Vector2(66, 64) - parent.position) / 5
		parent.scale += (Vector2(0.6, 0.6) - parent.scale) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse:
		pressed = true
		game.golde = true

func _on_area_2d_mouse_entered() -> void:
	mouse = true

func _on_area_2d_mouse_exited() -> void:
	mouse = false
