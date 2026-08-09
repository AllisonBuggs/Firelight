extends allMaps

@onready var natalie: NPCClass = $natalie
@onready var fog: TextureRect = $CanvasLayer2/cutscene/fog
@onready var natalie_distorted: TextureRect = $CanvasLayer2/cutscene/natalie_distorted
@onready var shade: ColorRect = $CanvasLayer2/cutscene/shade
@onready var cutscene_player: AnimationPlayer = $CanvasLayer2/cutscene/cutscene_player

func _ready() -> void:
	setUpMap()
	GlobalMusicPlayer.changeMusic("FEEL")

func destination_reacjed():
	await natalie.navigation_agent.navigation_finished
