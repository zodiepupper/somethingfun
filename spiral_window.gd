class_name SpiralWindow
extends Window

const CLICK_BLANK = preload("uid://daxf4k44rdmb1")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	audio_stream_player.stream = CLICK_BLANK
	audio_stream_player.play()

## if the user presses the escape key, let them escape
func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event as InputEventKey).keycode == KEY_ESCAPE and event.is_pressed():
		queue_free()

## if the user has been conditioned, let them escape
func _on_audio_stream_player_finished() -> void:
	queue_free()
