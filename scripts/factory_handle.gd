extends Area2D

@onready var game = %GameManager
@onready var area = $"."
var mouse = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if game.factories > 0:
		area.visible = true
		if game.facset:
			area.position.y += (100 - area.position.y) / 5
		if mouse:
			area.position.y += (295 - area.position.y) / 5
		else:
			area.position.y += (264 - area.position.y) / 5
	else:
		area.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and game.factories > 0 and mouse and !game.black:
		game.facset = true

func _on_mouse_entered() -> void:
	mouse = true

func _on_mouse_exited() -> void:
	mouse = false
