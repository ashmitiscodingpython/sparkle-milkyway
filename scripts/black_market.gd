extends Area2D

@onready var area = $"."
@onready var game = %GameManager
@onready var back = $"../Black Background"
@onready var cc = $"../CPC Counter"
@onready var mc = $"../Cookie Counter Parent"
@onready var cookie = $"../Cookie"
@onready var stock_label = $"../Black Background/stock count"
@onready var stonkss = $"../Black Background/stonkss"
@onready var stock_val = $"../Black Background/stock value"
@onready var pl = $"../Black Background/P_L_Percent"
@onready var plnum = $"../Black Background/P_L_#"
var mcx = 0
var mouse = false

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var x = area.position.x
	var bbx = back.position.x
	var ccx = game.ccx
	var cook_x = cookie.cx_b
	if game.black_market:
		area.visible = true
		if !game.black and !game.open:
			bbx += (-300 - bbx) / 5
			@warning_ignore("integer_division")
			mcx += (0 - mcx) / 5
			cook_x += (0 - cook_x) / 5
			ccx += (0 - ccx) / 5
			if mouse:
				x += (120 - area.position.x) / 5
			else:
				x += (64 - area.position.x) / 5
		elif game.black:
			cook_x += (175 - cook_x) / 5
			ccx += (400 - ccx) / 5
			x += (-150 - area.position.x) / 5
			bbx += (150 - bbx) / 5
			@warning_ignore("integer_division")
			mcx += (175 - mcx) / 5
		else:
			x += (64 - area.position.x) / 5
	else:
		area.visible = false
	game.mcx_a = mcx
	back.position.x = bbx
	area.position.x = x
	cookie.cx_b = cook_x
	game.ccx = ccx
	stock_label.text = "Stocks bought: " + str(game.no_stocks)
	stock_val.text = "Stock value: " + str(game.acc_s)
	if game.no_stocks > 0:
		var plnumber = (float(game.no_stocks) * float(game.acc_s)) - game.buy_cost
		var percent = str(int((((float(game.no_stocks) * float(game.acc_s)) / float(game.buy_cost)) * 100) - 100)) + "%"
		if (game.buy_cost / game.no_stocks) < game.acc:
			percent = "+" + percent
			stonkss.default_color = Color(0.433, 1.0, 0.589, 1.0)
			plnum.text = "Profit: " + str(int(plnumber)) + "¢"
		else:
			stonkss.default_color = Color(1.0, 0.53, 0.557, 1.0)
			plnum.text = "Loss: " + str(int(abs(plnumber))) + "¢"
		percent = "\nPercent: " + percent
		pl.text = "Cookies spent: " + str(game.buy_cost) + percent
	else:
		stonkss.default_color = Color(1, 1, 1, 1)
		pl.text = ""
		plnum.text = ""
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse and !game.open:
		game.black = !game.black

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
