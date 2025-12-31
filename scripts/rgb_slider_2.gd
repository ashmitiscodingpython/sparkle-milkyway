extends Sprite2D

func _process(_delta: float) -> void:
	$".".modulate = %GameManager.factory_color
