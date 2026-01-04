extends Label

@onready var cookie = $"../Cookie Counter Parent"
@onready var lab = $"."
@onready var game = $"../GameManager"

func _ready() -> void:
	if !game.lava:
		lab.text = "+" + str(game.CPC)
	else:
		lab.text = "+" + str(game.CPC * 3)
	if game.open:
		lab.position = Vector2(randi_range(0, 700), 600)
	elif game.black:
		lab.position = Vector2(randi_range(370, 1123), 600)
	else:
		lab.position = Vector2(randi_range(0, 1123), 600) #correct

func _process(_delta: float) -> void:
	lab.position.y += (cookie.position.y - lab.position.y) / 15
	var dist = abs(cookie.position.y - lab.position.y)
	lab.modulate = Color(0.647, 1, 0.602, clamp(dist / 200, 0, 1))
	if round(dist) == 0:
		queue_free()
