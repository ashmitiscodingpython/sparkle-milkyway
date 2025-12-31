extends Line2D

@onready var stonks = $"."
@onready var game = %GameManager
var history = []
var graph: PackedVector2Array = []

func _ready() -> void:
	stonks.position.x -= 125

func _process(_delta: float) -> void:
	history.append(game.stocks)
	if len(history) > 58:
		history.pop_front()
	graph = []
	for i in range(len(history)):
		graph.append(Vector2((i * 5), history[i] / 5))
	stonks.points = graph
