extends AudioStreamPlayer2D

@onready var volume = $"../SettingsPrompt/Music"
var time = 0

func _process(_delta: float) -> void:
	time += _delta
	volume_db = (-5 + clamp(25 * time, 0, 25)) * remap(volume.value, 0, 1, -0.3, 1)
	if volume.value == 0:
		playing = false
	elif not playing:
		playing = true
