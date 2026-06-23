extends allMaps

@onready var queenSound = $QueenSoundMkaer
@onready var backgroundPlayer = $AnimationPlayer
@onready var allCutsceneSprites = $Cutscene
@onready var textLabel = $Cutscene/Camera2D/Label
@onready var camera = $Cutscene/Camera2D
@onready var fadeAnimationPlayer = $FadeAnimationPlayer
@onready var extraanimations = $extraanimations

func fadeOut():
	fadeAnimationPlayer.play_backwards("fade")

func _on_delay_intro_timer_timeout() -> void:
	backgroundPlayer.play("backgroundidle")
	fadeAnimationPlayer.play("fade")
	$delayIntroTimer.queue_free()

func queenSpeak():
	queenSound.play()
