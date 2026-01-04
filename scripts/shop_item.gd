extends Area2D

var mouse = false
@export var varient = 1
@export var cost = 0
var normal_y
var norm_scale
@onready var sprite = $Document1
@onready var area = $"."
@onready var game_manager = %GameManager
var namea
var last

func michelin():
	game_manager.masterchefs += 1
	var star = load("res://scenes/star.tscn").instantiate()
	last = star
	get_tree().current_scene.add_child(star)
	game_manager.stars += 1

var effects = {
	1: func(): game_manager.CPC += 1,
	2: func(): game_manager.CPS += 1,
	3: func(): game_manager.CPS += 15,
	4: func(): game_manager.CPC += 10,
	5: func(): if !game_manager.black_market: 
					game_manager.black_market = true
					game_manager.acc = 0,
	6: func(): game_manager.add_factory(),
	7: func(): game_manager.workers += 1,
	8: func(): game_manager.CPS += 100,
	9: func(): michelin(),
	10: func(): if true:
		game_manager.CPS += 10_000_000
		game_manager.cookiemonster = true,
	11: func(): if !game_manager.lava: 
		game_manager.lava = true
		game_manager.lav()
}

func _ready() -> void:
	normal_y = area.position.y
	norm_scale = area.scale.x
	match varient:
		1: namea = "more_dough"
		2: namea = "new_oven"
		3: namea = "hire_grandma"
		4: namea = "shop_"
		5: namea = "black_market"
		6: namea = "shop_factory"
		7: namea = "factory_worker"
		8: namea = "hands"
		9: namea = "michelin"
		10: namea = "cookie monster"
		11: namea = "llllava cccokie"
	sprite.texture = load("res://images/" + namea + ".png")

func _process(_delta: float) -> void:
	var exc = !(game_manager.black_market and varient == 5) and !(game_manager.factories > 0 and varient == 6) and \
				!(game_manager.factories == 0 and varient == 7) and !(game_manager.masterchefs > 17 and varient == 9) and \
				!(game_manager.lava and varient == 11) and !(game_manager.cookiemonster and varient == 10)
	if game_manager.cookies >= cost and exc and !game_manager.factory_color_prompt:
		area.modulate = Color(1.5, 1.5, 1.5, 1)
	else:
		area.modulate = Color(0.5, 0.5, 0.5, 1)
	if mouse and !game_manager.close_highlighted and game_manager.cookies >= cost and exc and !game_manager.factory_color_prompt:
		var scaled = ((norm_scale * 1.15) - area.scale.x) / 5
		area.scale += Vector2(scaled, scaled)
		$"../../ALT".touchtime += 1
		$"../../ALT".texture = load("res://images/" + namea + "_alt.png")
	else:
		var scaled = (norm_scale - area.scale.x) / 5
		area.scale += Vector2(scaled, scaled)
	area.position.y += ((normal_y + game_manager.shop_scroll) - area.position.y) / 5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index in [MOUSE_BUTTON_LEFT]:
		if mouse and game_manager.cookies >= cost and !game_manager.close_highlighted:
			var exc = !(game_manager.black_market and varient == 5) and !(game_manager.factories > 0 and varient == 6) and \
						!(game_manager.factories == 0 and varient == 7) and !(game_manager.masterchefs > 17 and varient == 9) and \
						!(game_manager.lava and varient == 11) and !(game_manager.cookiemonster and varient == 10)
			if exc and !game_manager.factory_color_prompt:
				$"../../PurchaseEffect".play()
				area.scale -= Vector2(0.1, 0.1)
				game_manager.cookies -= cost
				effects[varient].call()
				var trail = load("res://scenes/trace.tscn").instantiate()
				trail.position = area.global_position
				match varient:
					1: trail.target = $"../../CPC Counter"
					2: trail.target = $"../../CPS Counter"
					3: trail.target = $"../../CPS Counter"
					4: trail.target = $"../../CPC Counter"
					5: trail.target = $"../../Black Market"
					6: trail.target = $"../../Factory Handle"
					7: trail.target = $"../../Factory Handle"
					8: trail.target = $"../../CPS Counter"
					9: trail.target = last
					10: trail.target = $"../../Cookie"
					11: trail.target = $"."
				if varient == 6:
					game_manager.factory_color_prompt = true
				get_tree().get_current_scene().add_child(trail)

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
