extends Node2D
class_name allMaps
var currentMap

var doors = []
var actionables = []

var balloon : DialogueManagerExampleBalloon = null

@export var area : Area2D
@export var camera : Camera2D

@onready var audioStream = $AudioStreamPlayer
@onready var player = $Player
@onready var inventory = SaveLoad.SaveFileData.inventoryContents

var itemGivenText = ""
var currentUi = "none"
var cameraToUse = "playerBound"

var children
var mapLoaded = false
var entranceUsed

#Door related Variables
var destination
var mapPrefix

#Camera Settings
@export var LeftLimit = -10000000
@export var TopLimit = -10000000
@export var RightLimit = 10000000
@export var BottomLimit = 10000000

var playerMoveToggle = true

func _ready() -> void:
	setUpMap()

func setUpMap():
	GlobalSignalBus.emit_signal("changeCameraSettings", LeftLimit, TopLimit, RightLimit, BottomLimit)
	GlobalSignalBus.connect("transition_data", get_TransitionData)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if GlobalSignalBus.spawnDoorTag != null:
		onMapSpawn(GlobalSignalBus.spawnDoorTag)
	else: 
		onMapLoadSpawn()

func get_TransitionData(_mapToLoad: String, _entranceUsed: String):
	match _mapToLoad:
		"LabUpperFloor":
			currentMap = load("res://resources/scenes/maps/LabUpperFloor.tscn")
		"LabLowerFloor":
			currentMap = load("res://resources/scenes/maps/LabLowerFloor.tscn")
		"LabExterior":
			GlobalSignalBus.emit_signal("changeCameraSettings")
			currentMap = load("res://resources/scenes/maps/LabExterior.tscn")
		"JamesDownStairs":
			currentMap = load("res://resources/scenes/maps/JamesDownStairs.tscn")
		"JamesUpstairs":
			GlobalSignalBus.emit_signal("changeCameraSettings")
			currentMap = load("res://resources/scenes/maps/JamesUpstairs.tscn")

	GlobalSignalBus.emit_signal("activateCameraTransition")
	entranceUsed = _entranceUsed
	get_tree().change_scene_to_packed(currentMap)

func onMapLoadSpawn():
	GlobalSignalBus.triggerPlayerSpawn(SaveLoad.SaveFileData.player_position)

func onMapSpawn(doorTag):
	var doorPath = "Doors/Door_" + doorTag
	var door = get_node(doorPath) as Door
	print(door, doorPath)
	GlobalSignalBus.triggerPlayerSpawn(door.Spawn.global_position)

func playSound(path):
	audioStream.stream = load(path)
	audioStream.play()

func giveItem(itemID):
	var itemSpace = SaveLoad.SaveFileData.inventoryContents.find("None", 0)
	if itemSpace != -1:
		SaveLoad.SaveFileData.inventoryContents.set(itemSpace, itemID)
	print(SaveLoad.SaveFileData.inventoryContents)

func removeItem(ItemId):
	GlobalSignalBus.emit_signal("removeItem", ItemId)

func changeTexture(target, imagepath):
	target.texture = load(imagepath)

func changePlayerTexture(texturePath):
	GlobalSignalBus.emit_signal("changePlayerTexture", texturePath)

func playAnimation(animationName, animationPlayer, playBackwards):
	if playBackwards == false:
		animationPlayer.play(animationName)
	else:
		animationPlayer.play_backwards(animationName)

func freezePlayer():
	GlobalSignalBus.emit_signal("playerMovement", false)

func unfreezePlayer():
	GlobalSignalBus.emit_signal("playerMovement", true)

func changeScene(scenePath):
	get_tree().change_scene_to_file(scenePath)

func destory(object, arrayToRemoveFrom):
	if arrayToRemoveFrom == null:
		object.queue_free()
	else:
		arrayToRemoveFrom.remove_at(arrayToRemoveFrom.find(object))
		object.queue_free()

func changeDoorLock(doorName, isLocked):
	doorName.locked = isLocked
	doorName.update()

func unlockClosetDoor():
	var closetDoor = find_closest(doors)
	if is_instance_valid(closetDoor) :
		closetDoor.locked = false

func find_closest(objectArrayToFind):
	var lowest_distance = INF    # Initialized as infinity to avoid unintended behaviour at large distances
	var closest_object
	for object in objectArrayToFind:
		var distance = object.global_position.distance_squared_to(player.global_position)
		if distance < lowest_distance:
			closest_object = object
			lowest_distance = distance

	if !is_instance_valid(closest_object) or lowest_distance == INF:
		print("No valid Object found");
		return 

	return closest_object

func toggleVisiblity(object):
	object.visible = !object.visible

func changeCameraTarget(targetNode):
	camera.target = targetNode

func startCutscene(path):
	DialogueManager.show_dialogue_balloon_scene("res://resources/scenes/UI/balloon.tscn", load(path), "start")

func transitionRoom(mapToLoad, _entranceUsed):
	GlobalSignalBus.call_deferred("ChangeMap", mapToLoad, _entranceUsed)

func walk_to(npc_reference, goal_position : Vector2):
	npc_reference.movement_target = goal_position
	npc_reference.set_movement_target()
