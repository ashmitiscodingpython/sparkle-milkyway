extends Sprite2D

@onready var music = $Music
@onready var effects = $Effects
@onready var game = %GameManager
@onready var mus = $"../BackgroundMusic"
var norm = 0
var norp

func _ready() -> void:
	norm = mus.volume_db
	norp = position

func _process(_delta: float) -> void:
	game.effect_vol = effects.value
	mus.volume_db = norm * music.value
	if game.settings:
		position += (norp - position) / 5
	else:
		position += (Vector2(576, 800) - position) / 5
