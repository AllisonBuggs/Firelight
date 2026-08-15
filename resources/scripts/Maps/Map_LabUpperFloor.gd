extends allMaps

@onready var entrance_hall_second_door: Area2D = $Objects/EntranceHallSecondDoor
@onready var front_hall_do_entrance_hall_first_dooror_2: Area2D = $Objects/FrontHallDoEntranceHallFirstDooror2
@onready var camera_marker: Marker2D = $Cutscenes/CameraMarker
@onready var camera_marker_2: Marker2D = $Cutscenes/CameraMarker2
@onready var tenticle: Sprite2D = $Cutscenes/Tenticle
@onready var cutscene_player: AnimationPlayer = $Cutscenes/cutscene_player
@onready var lock_down_actionable: Area2D = $Actionables/LockDownActionable


@onready var cutscene_textures: CanvasLayer = $CutsceneTextures

func _ready() -> void:
	if SaveLoad.SaveFileData.LockdownTriggered == false:
		lock_down_actionable.queue_free()
	setUpMap()
	GlobalMusicPlayer.changeMusic("LAB_AMB")
