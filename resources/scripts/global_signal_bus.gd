extends Node

@warning_ignore_start("unused_signal")
signal container_data(contains)
signal transition_data(mapToLoad: String, entranceUsed: String)
signal interactableData(dialogText: String, facePath: String, nameBox: String)
signal playerMovement(canMove: bool)
signal resumeButtonPressed()
signal settingsButtonPressed()
signal saveButtonPressed()
signal returnButtonPressed()
signal pauseOpened()
signal settingsOpened()
signal saveloadMenuOpened()
signal inventoryOpened()
signal iventoryReturnButtonPressed()
signal playerPositionDataRequested(VectorToMoveTO)
signal activateCameraTransition()
signal playerEnteredCombat(target: String, state: String)
signal updatePlayerStats(Health: int, Stamina: int)
signal startCutscene(cutsceneName)
signal findDoorToMovePlayerTo(Doorname)
signal onTriggerPlayerSpawn()
signal attackRaycastInitiate(parentDamage)
signal updateJounral(journalName: String)
signal journalOpened()
signal changeMouseToCrossHair()
signal changeMouseToSelect()
signal changeCameraSettings()
signal closeAllMenus()
signal TriggerPopUp(text, timeOut)
signal changeMusic(songPath)
signal pauseMusic(pauseMusicBool : bool)
signal fadeMusic(Out : bool)
signal changePlayerTexture(imagePath : String)
signal detachPlayerCamera()
signal reattachPlayerCamera()
signal removeItem(ITEMID)

const StoneHelm = preload("res://resources/scenes/maps/StoneHelm.tscn")
const TestInterior = preload("res://resources/scenes/maps/TestInterior.tscn")
const LabExterior = preload("res://resources/scenes/maps/LabExterior.tscn")
const LabUpperFloor = preload("res://resources/scenes/maps/LabUpperFloor.tscn")
const LabLowerFloor = preload("res://resources/scenes/maps/LabLowerFloor.tscn")
const JamesUpstairs = preload("res://resources/scenes/maps/JamesUpstairs.tscn")
const JamesDownstairs = preload("res://resources/scenes/maps/JamesDownStairs.tscn")
const JamesHouseExterior = preload("res://resources/scenes/maps/JamesHouseExterior.tscn")
var spawnDoorTag

func ChangeMap(mapName, doorName):
	var mapToLoad
	match mapName:
		"LabExterior":
			mapToLoad = LabExterior
		"LabUpperFloor":
			mapToLoad = LabUpperFloor
		"LabLowerFloor":
			mapToLoad = LabLowerFloor
	if mapToLoad != null:
		spawnDoorTag = doorName
		get_tree().change_scene_to_packed(mapToLoad)

func triggerPlayerSpawn(position, direction):
	onTriggerPlayerSpawn.emit(position, direction)
