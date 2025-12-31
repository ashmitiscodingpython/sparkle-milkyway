extends Sprite2D

@onready var game = $"../GameManager"
@onready var cooka = $"../Cookie"
@onready var sprite = $"."
var index = 0
var sal = 0
var lasta = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.CPS += 500
	index = game.masterchefs

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var pres = int(game.startime / 10)
	if pres != sal and game.masterchefs > 0:
		if game.cookies > 5000:
			sprite.modulate = Color(1, 1, 1, 1)
			game.cookies -= 5000
			if !lasta:
				game.CPS += 500
				game.stars += 1
			lasta = true
		else:
			sprite.modulate = Color(0.8, 0.8, 0.8, 1)
			if lasta:
				game.CPS -= 500
				game.stars -= 1
			lasta = false
	sal = pres
	var rad = 130
	var extra = ((cooka.scale.x / 5.0) - 1) * 50
	var ex = 0
	if game.cookiemonster:
		ex = 25
	var x = (sin(deg_to_rad((game.startime + index) * 100)) * (rad + extra + ex)) + cooka.position.x
	var y = (cos(deg_to_rad((game.startime + index) * 100)) * (rad + extra + ex)) + cooka.position.y
	sprite.position = Vector2(x, y)
