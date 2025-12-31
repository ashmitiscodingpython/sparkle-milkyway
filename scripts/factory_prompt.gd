extends Sprite2D

@onready var game = %GameManager
@onready var sprite = $"."

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if game.facset:
		sprite.position.y += (376 - sprite.position.y) / 5
	else:
		sprite.position.y += (-200 - sprite.position.y) / 5
