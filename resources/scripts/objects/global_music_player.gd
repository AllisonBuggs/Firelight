extends AudioStreamPlayer

@onready var GlobalMusicAnimationPlayer = $GlobalMusicAnimationPlayer

var currentSong = "5PM"

# All Music
const LONESOME_WARMTH = preload("uid://bbm5qqnfo3mr")


func _ready() -> void:
	GlobalSignalBus.connect("fadeMusic", fadeMusic)
	GlobalSignalBus.connect("changeMusic", changeMusic)
	GlobalSignalBus.connect("pauseMusic", pauseMusic)

func changeMusic(songName):
	if songName != currentSong:
		match songName:
			"LONESOMEWARMTH":
				stream = LONESOME_WARMTH
				currentSong = "LONESOMEWARMTH"
		play()

func pauseMusic(pauseMusicBool):
	stream_paused = pauseMusicBool

func fadeMusic(Out):
	if Out == true: 
		GlobalMusicAnimationPlayer.play("FadeMusicOut")
	else:
		GlobalMusicAnimationPlayer.play_backwards("FadeMusicOut")
