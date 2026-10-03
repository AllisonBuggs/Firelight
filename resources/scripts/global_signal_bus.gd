extends Node

@warning_ignore_start("unused_signal")

#Player Signalss
signal playerMovement(canMove: bool)
signal playerPositionDataRequested(VectorToMoveTO: Vector2)
signal playerEnteredCombat(target: String, state: String)
signal updatePlayerStamina(Stamina: int)
signal updatePlayerHealth(Health: int)
signal changePlayerTexture(imagePath : String)
signal request_player_pos()
signal got_player_pos()
signal hit_connected()

# Boss Signals
signal update_boss_health_bar(current_health : int, before_health : int)
signal set_bar_max(new_max : int)

## Puppet Signals
signal move_puppet(pos : Vector2)
signal remove_puppet(puppet_key : String)
signal change_puppet_expression(puppet_key : String, expression_name : String) 

signal container_data(contains)
signal transition_data(mapToLoad: String, entranceUsed: String)
signal interactableData(dialogText: String, facePath: String, nameBox: String)

signal settingsButtonPressed()
signal saveButtonPressed()
signal returnButtonPressed()
signal pauseOpened()
signal settingsOpened()
signal saveloadMenuOpened()
signal inventoryOpened()
signal iventoryReturnButtonPressed()

signal activateCameraTransition()

signal startCutscene(cutsceneName)
signal findDoorToMovePlayerTo(Doorname)
signal onTriggerPlayerSpawn()

signal updateJounral(journalName: String)
signal journalOpened()
signal changeMouseToCrossHair()
signal changeMouseToSelect()
signal changeCameraSettings()
signal closeAllMenus()
signal TriggerPopUp(text, timeOut)

# GLOBAL MUSIC MANAGER
signal changeMusic(songPath)
signal pauseMusic(pauseMusicBool : bool)
signal fadeMusic(Out : bool)

signal detachPlayerCamera()
signal reattachPlayerCamera()
signal removeItem(ITEMID)

#Global Transition Scene
signal change_scene_with_transition()
signal play_transition(backwards : bool)

# Lab
#const LabExterior = preload("uid://c21gjtfrlt5bg")
const LabUpperFloor = preload("uid://cx8w08igip3oh")
const LabLowerFloor = preload("uid://2x767bx1tqky")

const SEWERS = preload("uid://q6kqktk4v0ys")

# Stone Helm
const HOLDING_ROOM = preload("uid://bkjfygcxvgqmh")

const CAIS_BEDROOM = preload("uid://cwnbqqaadnred")
const CAIS_FRONT_ROOM = preload("uid://bfqicqjwlcwtb")
const CAIS_HALLWAY = preload("uid://ddip3rc4dofki")
const CAIS_BATHROOM = preload("uid://dyl2k4jof3glf")

const CAI_APARTMENT_ENTRANCE = preload("uid://ynegjw8cighh")
const CAI_APARTMENT_HALL = preload("uid://455bg5qysh1w")
const APARTMENT_STAIRWAY = preload("uid://3qyup362mv1k")
const APARTMENT_STAIRWAY_MID = preload("uid://dchcn54dd6d6e")
const APARTMENT_STAIRWAY_TOP = preload("uid://d3u3nuembdyl2")
const holding_room_exterior = preload("uid://cm3ixshtsvv1w")
const HANGOUT_SPOT = preload("uid://cs6yji3hx61qx")
const NIGHT_WALK = preload("uid://daa8gf7y1ankg")

const BALLOON = preload("uid://cn1dkki7x6vy3")
var spawnDoorTag

func ChangeMap(mapName, doorName):
	var mapToLoad
	match mapName:
		"NIGHT_WALK":
			mapToLoad = NIGHT_WALK
		"HANGOUT_SPOT":
			mapToLoad = HANGOUT_SPOT
		"APARTMENT_STAIRWAY":
			mapToLoad = APARTMENT_STAIRWAY
		"APARTMENT_STAIRWAY_MID":
			mapToLoad = APARTMENT_STAIRWAY_MID
		"APARTMENT_STAIRWAY_TOP":
			mapToLoad = APARTMENT_STAIRWAY_TOP
		"CaiApartmentEntrance":
			mapToLoad = CAI_APARTMENT_ENTRANCE
		"CaiApartmentHall":
			mapToLoad = CAI_APARTMENT_HALL
		"":
			mapToLoad = CAIS_BATHROOM
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
		"holding_room_exterior":
			mapToLoad = holding_room_exterior
		"Sewers":
			mapToLoad = SEWERS
		#"LabExterior":
			#mapToLoad = LabExterior
		"LabUpperFloor":
			mapToLoad = LabUpperFloor
		"LabLowerFloor":
			mapToLoad = LabLowerFloor
	if mapToLoad != null:
		spawnDoorTag = doorName
		TransitionScene.play_transition(false)
		await TransitionScene.transition_player.animation_finished
		TransitionScene.play_transition(true)
		get_tree().change_scene_to_packed(mapToLoad)

func triggerPlayerSpawn(position):
	onTriggerPlayerSpawn.emit(position)
