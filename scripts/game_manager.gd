extends Node2D

@onready var cc = $"../CPC Counter"
@onready var cs = $"../CPS Counter"
@onready var mc = $"../Cookie Counter Parent"
@onready var factory = $"../FactoryIcon"
var cookies = 0
var black_market = false
@export var shop_scroll = 0
var CPC = 1
var CPS = 0
var mouse = false
var open = false
var stocks = 0
var acc = 0
var acc_s = 0
var black = false
var close_highlighted = false
var no_stocks = 0
var mcx_a = 0
var mcx_b = 0
var ccx = 0
var csx = 430
var buy_cost = 0
var factories = 0
var facset = false
var factory_wage = 5
var workers = 5
var cookie_value = 1
var comfort = 0.1
var income = 0
var masterchefs = 0
var startime = 0
var factory_color = Color(1, 1, 1, 1)
var factory_color_prompt = false
var unlocked = true
var lava = false
var lavatime = 0
var minus = 0
var stars = 0
var eighteen = false
var cookiemonster = false
var shop_unlock = false
var threexgold = false
var golde = false
var leftear = false
var rightear = 0
var settings = false
var effect_vol = 1
var effects: Array[AudioStreamPlayer2D]
var norms = []

func achievement() -> void:
	$"../AchievementSound".play()

func lav() -> void:
	minus = startime

func _ready() -> void:
	effects = [$"../AchievementSound", $"../ClickEffect", $"../GoldEffect", $"../PurchaseEffect", $"../HissEffect"]
	for effect in effects:
		print(effect)
		norms.append(effect.volume_db)

func add_factory() -> void:
	factories += 1
	factory.visible = true

func _process(_delta: float) -> void:
	var i = 0
	for effect in effects:
		effect.volume_db = norms[i] * effect_vol
		i += 1
	if stars == 18 and !eighteen:
		eighteen = true
		var achieve = load("res://scenes/achievement.tscn").instantiate()
		achieve.achievement = "Task Force"
		achieve.position = Vector2(1306, 76)
		get_tree().current_scene.add_child(achieve)
	if cookies > 0 and !shop_unlock:
		shop_unlock = true
		var achieve = load("res://scenes/achievement.tscn").instantiate()
		achieve.achievement = "Shop Unlock"
		achieve.position = Vector2(1306, 76)
		get_tree().current_scene.add_child(achieve)
	if golde and !threexgold:
		threexgold = true
		var achieve = load("res://scenes/achievement.tscn").instantiate()
		achieve.achievement = "3x Gold"
		achieve.position = Vector2(1306, 76)
		get_tree().current_scene.add_child(achieve)
	startime += _delta
	if !lava:
		minus = startime
	lavatime = startime - minus
	if lavatime > 10:
		lava = false
	cookie_value += randf_range(-0.002, 0.0021)
	cc.position.x = 50 + ccx
	cs.position.x = csx
	mc.position.x = 592 + mcx_a + mcx_b
	if randf_range(0.0000, 100.0000) < 0.01 and !golde:
		var gold = load("res://scenes/gold_3x.tscn").instantiate()
		get_tree().current_scene.add_child(gold)

func rand(weights: Dictionary) -> int:
	var total = 0
	var randu = randi_range(0, 100)
	var rando = 0
	for value in weights.values():
		total += value
		if randu < total:
			rando = weights.keys()[weights.values().find(value)]
			break
	return rando

func _update_stocks() -> void:
	acc += int(randi_range(-9, 9) * 500.0 / (500.0 + acc))
	acc = clamp(acc, 1, 100000000)
	acc_s += round((acc - acc_s) / 5)
	stocks = -acc_s

func _increase_cookies(increase) -> void:
	if !increase:
		if !lava:
			cookies += CPC
		else:
			cookies += 50 * CPC
	else:
		cookies += CPS

func toggle_shop() -> void:
	open = !open

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse:
		if event.button_index in [MOUSE_BUTTON_WHEEL_DOWN]:
			var limit = -505
			if unlocked: limit = -800
			if shop_scroll > limit:
				shop_scroll -= 10
			else:
				shop_scroll = limit
		elif event.button_index in [MOUSE_BUTTON_WHEEL_UP]:
			if shop_scroll < 0:
				shop_scroll += 10
			else:
				shop_scroll = 0
	
func _on_area_2d_mouse_entered() -> void:
	mouse = true

func _on_area_2d_mouse_exited() -> void:
	mouse = false
