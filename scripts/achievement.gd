extends Sprite2D

@export var achievement = "Task Force"
@onready var sprite = $"."
var game
var timer = 0

func _ready() -> void:
	game = $"../GameManager"
	match achievement:
		"Task Force": sprite.texture = load("res://images/achievement_task_force.png")
		"Shop Unlock": sprite.texture = load("res://images/achievement_shop_unlock.png")
		"3x Gold": sprite.texture = load("res://images/achievement_3x_gold.png")
	game.achievement()
	match achievement:
		"Task Force": game.cookies += 50_000

func _process(_delta: float) -> void:
	var dif = (Vector2(1003, 75) - sprite.position)
	sprite.position += dif / 5
	if abs(dif.x + dif.y) < 1:
		timer += _delta
	if timer > 2.5:
		var col = sprite.modulate
		col.a += (0 - col.a) / 5
		sprite.modulate = col
	if timer > 3.5:
		queue_free()
