class_name SpiralWindow
extends Window

#const CLICK_BLANK = preload("res://clips/click_blank.mp3")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_locate_clips_and_play()
	#audio_stream_player.stream = CLICK_BLANK
	#audio_stream_player.play()

## if the user presses the escape key, let them escape
func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event as InputEventKey).keycode == KEY_ESCAPE and event.is_pressed():
		queue_free()

## if the user has been conditioned, let them escape
func _on_audio_stream_player_finished() -> void:
	queue_free()

## this method tries to find the puppy_clips
func _locate_clips_and_play() -> void:
	# try to get a list of all the clips in the puppy_clips
	var clips : Array = DirAccess.get_files_at("./puppy_clips/")
	# filter the clips
	clips = clips.filter(_filter_files_for_audio_types)
	# pick a random clip
	var clip_to_load = clips.pick_random()
	# import and play the clip
	if clip_to_load.ends_with(".wav"):
		audio_stream_player.stream = AudioStreamWAV.load_from_file("./puppy_clips/"+clip_to_load)
	if clip_to_load.ends_with(".mp3"):
		audio_stream_player.stream = AudioStreamMP3.load_from_file("./puppy_clips/"+clip_to_load)
	if clip_to_load.ends_with(".ogg"):
			audio_stream_player.stream = AudioStreamOggVorbis.load_from_file("./puppy_clips/"+clip_to_load)
	audio_stream_player.play()

## this is specifically to filter the file list down to only supported audio files
func _filter_files_for_audio_types(file:String):
	# gets the last 4 characters for the match
	match file.substr(file.length()-4):
		".wav", ".mp3", ".ogg":
			return file
