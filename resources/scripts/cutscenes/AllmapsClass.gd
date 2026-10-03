extends Node2D
var currentMap


@export var area : Area2D
@onready var allCutsceneSprites = $Cutscene
@onready var audioStream = $AudioStreamPlayer
@onready var player = $Player
@onready var camera = $Cutscene/Camera2D

var currentUi = "none"
var cameraToUse = "playerBound"

var children
var mapLoaded = false
var entranceUsed

#Door related Variables
var destination
var mapPrefix

func _ready() -> void:
	GlobalSignalBus.connect("transition_data", get_TransitionData)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	if GlobalSignalBus.spawnDoorTag != null:
		onMapSpawn(GlobalSignalBus.spawnDoorTag)

func get_TransitionData(_mapToLoad: String, _entranceUsed: String):
	match _mapToLoad:
		"LabUpperFloor":
			currentMap = load("res://resources/scenes/maps/LabUpperFloor.tscn")
		"LabLowerFloor":
			currentMap = load("res://resources/scenes/maps/LabLowerFloor.tscn")
		"LabExterior":
			GlobalSignalBus.emit_signal("changeCameraSettings")
			currentMap = load("res://resources/scenes/maps/LabExterior.tscn")

	GlobalSignalBus.emit_signal("activateCameraTransition")
	entranceUsed = _entranceUsed
	get_tree().change_scene_to_packed(currentMap)

func onMapSpawn(doorTag):
	print_tree_pretty()
	var doorPath = "Doors/Door_" + doorTag
	print(doorPath)
	var door = get_node(doorPath) as Door
	GlobalSignalBus.triggerPlayerSpawn(door.Spawn.global_position)

func playSound(path):
	audioStream.stream = load(path)
	audioStream.play()

func giveItem(itemID):
	var itemSpace = player.inventoryContents.find("None", 0)
	if itemSpace != -1:
		player.inventoryContents.set(itemSpace, itemID)
	print(player.inventoryContents)

func CarBump():
	camera.add_trauma()

func changeTexture(target, imagepath):
	target.texture = load(imagepath)
