extends Area2D

var mcx = 0
var mouse = false
@onready var are = $"."
@onready var game_manager = %GameManager
@onready var shop_back = $"../Shop Background"
@onready var mc = $"../Cookie Counter Parent"
@onready var cc = $"../CPS Counter"
@onready var cook = $"../Cookie"

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var x = are.position.x
	var sx = shop_back.position.x
	var ccx = cc.position.x
	var cook_x = cook.cx_a
	if !game_manager.open:
		ccx += (473 - ccx) / 5
		shop_back.position += Vector2((1677 - sx) / 5, 0)
		@warning_ignore("integer_division")
		mcx += (0 - mcx) / 5
		cook_x += (0 - cook_x) / 5
		if !game_manager.shop_unlock:
			are.position += Vector2((1300 - x) / 5, 0)
		elif mouse and !game_manager.black:
			are.position += Vector2((1010 - x) / 5, 0)
		else:
			are.position += Vector2((1071 - x) / 5, 0)
	else:
		cook_x += (-242 - cook_x) / 5
		shop_back.position += Vector2((1000 - sx) / 5, 0)
		@warning_ignore("integer_division")
		mcx += (-242 - mcx) / 5
		are.position += Vector2((1300 - x) / 5, 0)
		ccx += (75 - ccx) / 5
	game_manager.csx = ccx
	game_manager.mcx_b = mcx
	game_manager.csx = ccx
	cook.cx_a = cook_x

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if mouse and !game_manager.black:
			game_manager.toggle_shop()

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
