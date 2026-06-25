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

# Lab
const LabExterior = preload("uid://c21gjtfrlt5bg")
const LabUpperFloor = preload("uid://cx8w08igip3oh")
const LabLowerFloor = preload("uid://2x767bx1tqky")

const SEWERS = preload("uid://q6kqktk4v0ys")

# Stone Helm
const HOLDING_ROOM = preload("uid://bkjfygcxvgqmh")

const CAIS_BEDROOM = preload("uid://cwnbqqaadnred")
const CAIS_FRONT_ROOM = preload("uid://bfqicqjwlcwtb")
const CAIS_HALLWAY = preload("uid://ddip3rc4dofki")
const CAIS_BATHROOM = preload("uid://dyl2k4jof3glf")
const STONE_HELM = preload("uid://dcuq0tvhmqs2l")


var spawnDoorTag

func ChangeMap(mapName, doorName):
	var mapToLoad
	match mapName:
		"CaiBathroom":
			mapToLoad = CAIS_BATHROOM
		"CaiHallway":
			mapToLoad = CAIS_HALLWAY
		"CaiFrontRoom":
			mapToLoad = CAIS_FRONT_ROOM
		"CaiBedroom":
			mapToLoad = CAIS_BEDROOM
		"HoldingRoom":
			mapToLoad = HOLDING_ROOM
		"Stonehelm":
			mapToLoad = STONE_HELM
		"Sewers":
			mapToLoad = SEWERS
		"LabExterior":
			mapToLoad = LabExterior
		"LabUpperFloor":
			mapToLoad = LabUpperFloor
		"LabLowerFloor":
			mapToLoad = LabLowerFloor
	if mapToLoad != null:
		spawnDoorTag = doorName
		get_tree().change_scene_to_packed(mapToLoad)

func triggerPlayerSpawn(position):
	onTriggerPlayerSpawn.emit(position)
