extends allMaps


@onready var cutscene_animation_player: AnimationPlayer = $Cutscenes/cutsceneAnimationPlayer
@onready var cutscene_light: PointLight2D = $Cutscenes/cutsceneLight
@onready var cutscenes: Node2D = $Cutscenes

func _ready() -> void:
	setUpMap()
	GlobalMusicPlayer.changeMusic("NIGHT1")
