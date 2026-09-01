extends AudioStreamPlayer

@onready var GlobalMusicAnimationPlayer = $GlobalMusicAnimationPlayer

var currentSong = "5PM"

# All Music
const ANOTHER_KID = preload("uid://cq4ad14nvxhh4")
const DARKER_EYES = preload("uid://b6d21s03h1d0o")
const SEWER_AMB = preload("uid://dfy6h7isdjx0l")
const NATALIES_BOX = preload("uid://dvj5w2pi26aw2")
const NEW_MOM = preload("uid://bfovpgvsh6tab")
const OLD_WORLD = preload("uid://budmk3j0u3msb")
const NEW_HOME = preload("uid://bsm6wo8xxyfl8")
const MAIN_THEME = preload("uid://bnx6dqnss7tor")

func _ready() -> void:
	GlobalSignalBus.connect("fadeMusic", fadeMusic)
	GlobalSignalBus.connect("changeMusic", changeMusic)
	GlobalSignalBus.connect("pauseMusic", pauseMusic)

func changeMusic(songName):
	if songName != currentSong:
		match songName:
			"ANOTHER_KID":
				stream = ANOTHER_KID
				currentSong = "ANOTHER_KID"
			"DARKER_EYES":
				stream = DARKER_EYES
				currentSong = "DARKER_EYES"
			"SEWER_AMB":
				stream = SEWER_AMB
				currentSong = "SEWER_AMB"
			"NATALIES_BOX":
				stream = NATALIES_BOX
				currentSong = "NATALIES_BOX"
			"NEW_MOM":
				stream = NEW_MOM
				currentSong = "NEW_MOM"
			"OLD_WORLD":
				stream = OLD_WORLD
				currentSong = "OLD_WORLD"
			"NEW_HOME":
				stream = NEW_HOME
				currentSong = "NEW_HOME"
			"MAIN_THEME":
				stream = MAIN_THEME
				currentSong = "MAIN_THEME"
		play()

func pauseMusic(pauseMusicBool):
	stream_paused = pauseMusicBool

func fadeMusic(Out):
	if Out == true: 
		GlobalMusicAnimationPlayer.play("FadeMusicOut")
	else:
		GlobalMusicAnimationPlayer.play_backwards("FadeMusicOut")
