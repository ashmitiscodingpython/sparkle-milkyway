extends Sprite2D

@onready var sprite = $"."
@onready var game = %GameManager

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if game.factory_color_prompt:
		sprite.position.y += (405 - sprite.position.y) / 5
	else:
		sprite.position.y += (900 - sprite.position.y) / 5
