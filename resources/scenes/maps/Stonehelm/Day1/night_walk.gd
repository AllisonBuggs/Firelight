extends allMaps

@onready var natalie: NPCClass = $natalie
@onready var fog: TextureRect = $UiCanvasLayer/cutscene/fog
@onready var natalie_distorted: TextureRect = $UiCanvasLayer/cutscene/natalie_distorted
@onready var cutscene_player: AnimationPlayer = $UiCanvasLayer/cutscene/cutscene_player

func _ready() -> void:
	setUpMap()
	GlobalMusicPlayer.changeMusic("FEEL")

func destination_reacjed():
	await natalie.navigation_agent.navigation_finished
