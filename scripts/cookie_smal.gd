extends RigidBody2D

var golden = false
@onready var phy = $"."
@onready var game = $"../GameManager"
@onready var sprite2d = $Sprite2D

func _ready() -> void:
	if golden:
		sprite2d.texture = load("res://images/golden cookie.png")
	phy.position = get_global_mouse_position()
	phy.apply_central_force(Vector2(randi_range(-10000, 10000), -10000))

func _process(_delta: float) -> void:
	if game.lava:
		sprite2d.texture = load("res://images/leva cokie.png")
	if phy.position.y > 850:
		queue_free()
