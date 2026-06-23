extends allMaps

@onready var cutsceneItems = $Cutscenes
@onready var cutsceneLight = $Cutscenes/cutsceneLight
@onready var cutsceneAnimationPlayer = $Cutscenes/cutsceneAnimationPlayer
@onready var mixingUI = $UiCanvasLayer/MixingUi
@onready var fleshWall = $fleshWall
@onready var meatwall_1: TileMapLayer = $Meatwall1
@onready var meatwall_2: TileMapLayer = $Meatwall2
@onready var fleshwall_actionable: Area2D = $Actionable/FleshwallActionable
@onready var exp_2_break_door: Area2D = $Actionable/EXP2BreakDoor
@onready var maintence_break_door: Area2D = $Actionable/maintenceBreakDoor
@onready var main_lab_break_door: Area2D = $Actionable/mainLabBreakDoor



var toggle = false

func _ready() -> void:
	actionables = [$Actionable/EXP2BreakDoor,$Actionable/maintenceBreakDoor, $Actionable/FleshwallActionable,$Actionable/mainLabBreakDoor]
	doors = [$Doors2/LabDoor, $Doors2/LabDoor2, $Doors2/LabDoor4, $Doors2/LabDoor3]
	GlobalSignalBus.emit_signal("changeMusic", "res://resources/music/RustedFactorySecond.mp3")
	if SaveLoad.SaveFileData.burned_away_flesh == true:
		fleshWall.queue_free()
		meatwall_1.queue_free()
		meatwall_2.queue_free()
		fleshwall_actionable.queue_free()
	if SaveLoad.SaveFileData.barricaded_lab_door == false:
		main_lab_break_door.queue_free()
	if SaveLoad.SaveFileData.barricaded_exp2_door == false:
		exp_2_break_door.queue_free()
	if SaveLoad.SaveFileData.barricaded_maintence_door == false:
		maintence_break_door.queue_free()
	setUpMap()
