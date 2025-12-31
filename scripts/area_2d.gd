extends Area2D

@export var m_p = "P"
@onready var area = $"."
@onready var game = %GameManager
@onready var wage_counter = $"../wage_counter"
@onready var workers_ = $"../workers"
@onready var happy = $"../happy"
@onready var expect = $"../expectation"
@onready var income = $"../income"
var ews = 2
var expected_wage = 2
var wage_plus
var mouse_minus = false
var mouse_plus = false
var happiness = 100
var extra = 0
var last = 0
var last_comf = 0
var accumulative = 0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	expected_wage = game.cookie_value * 5 + extra
	if last_comf != game.comfort: accumulative += (clamp(5 - game.comfort, 0, 5) / 2)
	last_comf = game.comfort
	if game.factory_wage > last:
		extra += 0.3
	elif game.factory_wage < last:
		extra -= 0.1
	var bh = ((game.factory_wage / expected_wage) * 100) + accumulative
	happiness = str(int(bh)) + "%"
	expect.text = "Expectation: " + str(int(expected_wage * 10) / 10.0) + " ¢"
	happy.text = "Happiness: " + happiness
	var bi = int(((bh / 100) * 30) * 10) / 10.0
	income.text = "Income: " + str(bi) + " ¢"
	game.income = bi * game.workers
	if m_p == "P":
		wage_counter.text = "Wage: " + str(game.factory_wage) + " ¢"
		workers_.text = str(game.workers) + " workers"
		if mouse_plus:
			area.scale += (Vector2(1.15, 1.15) - area.scale) / 5
		else:
			area.scale += (Vector2(1, 1) - area.scale) / 5
	else:
		wage_plus = $"../wage+"
		if wage_plus.mouse_minus:
			area.scale += (Vector2(1.15, 1.15) - area.scale) / 5
		else:
			area.scale += (Vector2(1, 1) - area.scale) / 5
	last = game.factory_wage

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and game.factories > 0 and ((m_p == "P" and mouse_plus) or (m_p == "M" and wage_plus.mouse_minus)):
		if m_p == "P":
			game.factory_wage += 1
		else:
			if game.factory_wage > 0:
				game.factory_wage -= 1
		area.scale -= Vector2(0.1, 0.1)

func _on_mouse_entered() -> void:
	mouse_plus = true

func _on_mouse_exited() -> void:
	mouse_plus = false

func _on_wage_mouse_entered() -> void:
	mouse_minus = true

func _on_wage_mouse_exited() -> void:
	mouse_minus = false
