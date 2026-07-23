extends allMaps
@onready var cutsceneAnimationPlayer: AnimationPlayer = $cutsceneItems/cutsceneAnimationPlayer
@onready var cutsceneLight: PointLight2D = $cutsceneItems/cutsceneLight
@onready var cutsceneItems: Node2D = $cutsceneItems

func _ready() -> void:
	setUpMap()
	GlobalMusicPlayer.changeMusic("NIGHT1")
