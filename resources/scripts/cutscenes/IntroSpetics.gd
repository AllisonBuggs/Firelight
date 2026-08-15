extends allMaps

@onready var queenSound = $QueenSoundMkaer
@onready var backgroundPlayer = $AnimationPlayer
@onready var allCutsceneSprites = $Cutscene
@onready var textLabel = $Cutscene/Camera2D/Label
@onready var fadeAnimationPlayer = $FadeAnimationPlayer
@onready var extraanimations = $extraanimations
@onready var camera_center: Marker2D = $camera_center

func fadeOut():
	fadeAnimationPlayer.play_backwards("fade")

func _on_delay_intro_timer_timeout() -> void:
	backgroundPlayer.play("backgroundidle")
	fadeAnimationPlayer.play("fade")
	$delayIntroTimer.queue_free()

func queenSpeak():
	queenSound.play()
