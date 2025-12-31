extends Sprite2D

@export var vari = 0
@onready var parent = $"../.."
@onready var sprite = $".."
@onready var me = $"."
@onready var game = %GameManager
var mouse = false

func _process(_delta: float) -> void:
	if mouse or (game.leftear and vari == 0) or (game.rightear and vari == 1):
		sprite.texture = load("res://images/closedeye.png")
		me.texture = null
	else:
		sprite.texture = load("res://images/eye_back.png")
		me.texture = load("res://images/eye_fore.png")
		var pos = get_global_mouse_position() - global_position
		var dir = rad_to_deg(atan2(pos.y, pos.x)) + 90
		position.x = sin(deg_to_rad(dir)) * 67
		position.y = cos(deg_to_rad(dir)) * -67


func _on_area_2d_mouse_entered() -> void:
	if vari == 0: mouse = true

func _on_area_2d_mouse_exited() -> void:
	if vari == 0: mouse = false

func _on_area_2d_2_mouse_entered() -> void:
	if vari == 1: mouse = true

func _on_area_2d_2_mouse_exited() -> void:
	if vari == 1: mouse = false
