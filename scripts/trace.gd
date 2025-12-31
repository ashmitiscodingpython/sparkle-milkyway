extends GPUParticles2D

@onready var particle = $"."
var target: Node
var over = false
var timer = 0
var elapse = 0

func get_control_center(ctrl: Control) -> Vector2:
	return ctrl.global_position + ctrl.size / 2 + Vector2(ctrl.get_minimum_size().x / 2, 0)

func _ready() -> void:
	particle.emitting = true

func _process(delta: float) -> void:
	elapse += delta
	var pos = target.global_position
	if target is Control:
		pos = get_control_center(target)
	particle.position += (pos - particle.global_position) / 15
	var difx = pos.x - particle.position.x
	var dify = pos.y - particle.position.y
	if abs(difx + dify) < 1:
		if !over:
			timer = elapse
			over = true
		particle.emitting = false
	if over and (elapse - timer) > 1:
		queue_free()
