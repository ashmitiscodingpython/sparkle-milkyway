extends Sprite2D

@onready var game = %GameManager
@onready var left = $"../IntroLeft"
@onready var right = $"../IntroRight"
var mouse = false

func _process(_delta: float) -> void:
	if mouse and not game.introed:
		scale += ((1.2 * Vector2(1.7, 1.7)) - scale) / 5
	elif not game.introed:
		scale += (Vector2(1.7, 1.7) - scale) / 5
	if game.introed:
		scale += (Vector2(0, 0) - scale) / 10
		left.position.x += (-700 - left.position.x) / 5
		right.position.x += (1400 - right.position.x) / 5
		$"../CPUParticles2D".emitting = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse:
		scale += (Vector2(0, 0) - scale) / 10
		game.introed = true

func mouse_entered() -> void:
	mouse = true

func mouse_exited() -> void:
	mouse = false
