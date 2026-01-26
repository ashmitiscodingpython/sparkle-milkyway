extends Sprite2D

@onready var music = $Music
@onready var effects = $Effects
@onready var game = %GameManager
var norp

func _ready() -> void:
	norp = Vector2(576, 368.17)

func _process(_delta: float) -> void:
	game.effect_vol = remap(effects.value, 0, 1, -0.3, 1)
	if game.settings:
		position += (norp - position) / 5
	else:
		position += (Vector2(576, 800) - position) / 5
