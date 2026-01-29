extends AudioStreamPlayer2D

@onready var volume = $"../SettingsPrompt/Music"
var time = 0

func _process(_delta: float) -> void:
	time += _delta
	if %GameManager.introed:
		volume_db = (-5 + clamp(25 * time, 0, 25)) * remap(volume.value, 0, 1, -0.3, 1)
		if volume.value == 0:
			stream_paused = true
		elif stream_paused:
			stream_paused = false
	else:
		volume_db = 2
