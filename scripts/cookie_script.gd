extends Area2D

@onready var area = $"."
@onready var sprite = $cooki
@onready var collider = $Collider.shape
@onready var game_manager = %GameManager
@onready var cookies = $"../Cookie Counter Parent/Cookie Counter"
@onready var CPC = $"../CPC Counter"
@onready var CPS = $"../CPS Counter"
@onready var back = $"../Background"
var goldpress = false
var mouse_on = false
var time_sec = 0.0
var cx_a = 0
var cx_b = 0
var alternate = true
var alt = 0
var alttt = false
var al = false
var mouse_click = false
var boiling = 0
var heat_disable = false

func _ready() -> void:
	area.scale = Vector2(1, 1)
	var img = load("res://images/cursor2.png").get_image()
	var scalen = 64 - (10 if mouse_click else 0)
	img.resize(scalen, scalen)
	var tex = ImageTexture.create_from_image(img)
	Input.set_custom_mouse_cursor(tex)

func _process(delta: float) -> void:
	if game_manager.golde:
		goldpress = true
	else:
		goldpress = false
	if game_manager.lava:
		back.texture = load("res://images/levaback.png")
		back.stretch_mode = 0
		sprite.texture = load("res://images/leva cokie.png")
	else:
		sprite.texture = load("res://images/cookie.png")
		back.texture = load("res://images/Yellow.png")
		back.stretch_mode = 1
	$".".position.x = 592 + cx_a + cx_b
	time_sec += delta
	area.rotation = sin(time_sec * 3) * 0.3
	if mouse_on and !game_manager.factory_color_prompt and !heat_disable:
		area.scale += (Vector2(6, 6) - area.scale) / 10
	else:
		area.scale += (Vector2(5, 5) - area.scale) / 10
	game_manager.cookies += delta * game_manager.CPS
	cookies.text = Globals.shorten_number(int(game_manager.cookies))
	CPC.text = "CPC:" + str(Globals.shorten_number(game_manager.CPC))
	CPS.text = "CPS:" + str(Globals.shorten_number(game_manager.CPS))
	game_manager._update_stocks()
	if alternate:
		alt += 1
		alternate = !(alt % 10 == 0)
	else:
		alt -= 1
		alternate = (alt % 10 == 0)
	if alt == 10:
		alttt = true
	else:
		alttt = false
	if alttt: al = !al
	if game_manager.factories > 0:
		if al and alt == 10:
			game_manager.cookies -= game_manager.factory_wage * game_manager.workers
		elif !al and alt == 10:
			game_manager.cookies += game_manager.income
	if game_manager.cookiemonster:
		$Ear.visible = true
		$Ear2.visible = true
		$Area2D.visible = true
		$Area2D2.visible = true
	var hiss: AudioStreamPlayer2D = $"../HissEffect"
	if boiling > 50 and !heat_disable:
		heat_disable = true
	if heat_disable:
		scale += (Vector2(2, 2) - scale) / 5
		if boiling < 3:
			heat_disable = false
	if boiling > 1:
		var cond = game_manager.effect_vol == -0.3
		if !hiss.playing and !cond:
			hiss.play()
		if cond and hiss.playing:
			hiss.stop()
		hiss.volume_db = ((boiling / 5.0) + randf_range(-12.0, 1.0)) * game_manager.effect_vol
	else:
		hiss.stop()
	if boiling > 0:
		boiling += (0 - boiling) / 50.0
	$"../AchievementSound".volume_db = 1.025 * remap(game_manager.effect_vol, -0.3, 1, -23, 1)
	$"../PurchaseEffect".volume_db = remap(game_manager.effect_vol, -0.3, 1, -23, 0)
	$"../GoldEffect".volume_db = 0 - (63 * remap(game_manager.effect_vol, -0.3, 1, 1, 0))
	$"../ColorRect".material.set_shader_parameter("thresh", boiling / 22.0)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index in [MOUSE_BUTTON_LEFT]:
		if mouse_on and !game_manager.factory_color_prompt and !heat_disable:
			$"../ClickEffect".play()
			area.scale += Vector2(1, 1)
			var sma_cook = load("res://scenes/cookie_smal.tscn")
			var obj = sma_cook.instantiate()
			var add_text = load("res://scenes/label.tscn")
			var ob = add_text.instantiate()
			var goldie = false
			if goldpress:
				goldie = randi_range(0, 100) < 3
			else:
				goldie = randi_range(0, 100) == 1
			if goldie:
				$"../GoldEffect".play()
				var gold = load("res://scenes/gold_star_particles.tscn").instantiate()
				obj.golden = true
				game_manager.cookies += 500
				gold.position = get_global_mouse_position()
				gold.restart()
				gold.emitting = true
				get_tree().current_scene.add_child(gold)
			else:
				game_manager._increase_cookies(false)
			ob.game = %GameManager
			get_tree().current_scene.add_child(obj)
			get_tree().current_scene.add_child(ob)
			if game_manager.lava:
				boiling += 10
			%Camera2D.shake = boiling / 10.0
	if event is InputEventMouseButton:
		if event.pressed:
			mouse_click = true
		else:
			mouse_click = false
	if game_manager.CPC > 1000:
		if game_manager.CPS > 10_000:
			if game_manager.factories > 0:
				if game_manager.black_market:
					if game_manager.masterchefs == 18:
						game_manager.unlocked = true

func _on_mouse_entered() -> void:
	mouse_on = true

func _on_mouse_exited() -> void:
	mouse_on = false
