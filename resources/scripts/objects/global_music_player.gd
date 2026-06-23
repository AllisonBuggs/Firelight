extends AudioStreamPlayer

@onready var GlobalMusicAnimationPlayer = $GlobalMusicAnimationPlayer

var currentSong = "5PM"

func _ready() -> void:
	GlobalSignalBus.connect("fadeMusic", fadeMusic)
	GlobalSignalBus.connect("changeMusic", changeMusic)
	GlobalSignalBus.connect("pauseMusic", pauseMusic)

func changeMusic(songPath):
	stream = load(songPath)

func pauseMusic(pauseMusicBool):
	stream_paused = pauseMusicBool

func fadeMusic(Out):
	if Out == true: 
		GlobalMusicAnimationPlayer.play("FadeMusicOut")
	else:
		GlobalMusicAnimationPlayer.play_backwards("FadeMusicOut")
