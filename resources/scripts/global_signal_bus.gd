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

#Tower
const LOST_CITY = preload("uid://ssbekyf32bxx")
const LOST_TOWN = preload("uid://s6h3nsg41f68")
const RAT_ROOM = preload("uid://bpt7vwryappoq")
const TOWER_APARTMENTS = preload("uid://kp45drcwg2jn")
const TOWER_BALCONY = preload("uid://bhakyfcxj4dsf")
const TOWER_LOBBY = preload("uid://biomyr818rj08")
const TOWER_MEATLOCKER = preload("uid://cbmi5u6t6c5id")
const TOWER_STAIRWAY_1 = preload("uid://bqq6goygt8eub")
const TOWER_STAIRWAY_2 = preload("uid://cldkm36bm0dj1")

# Lab
const LabUpperFloor = preload("uid://cx8w08igip3oh")
const LabLowerFloor = preload("uid://2x767bx1tqky")

# StoneHelm
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
const AUBREYS_APARTMENT = preload("uid://bgggc6qcagbg8")
const HAROLDS_OFFICE = preload("uid://cj2p47avs6fix")
const NATALIES_HOUSE = preload("uid://28vss2pscypy")
const BALCONY_DAY_1 = preload("uid://70ywnqp1ndh0")
const WALK_TO_THE_PARK = preload("uid://cm3ixshtsvv1w")
const MISC_ROOMS_MAP = preload("uid://djibpy4welrep")

# Sewer
const SEWER_CAI_HALL = preload("uid://cqsufl0ic0nai")
const SEWER_PUZZLE_ROOM = preload("uid://cayhj1886484a")
const SEWERS = preload("uid://q6kqktk4v0ys")

const SUBMARINE_DOCK = preload("uid://8bhrt3m4bnny")

# Stonehelm : Medical Lab
const MEDICAL_LAB = preload("uid://d0nqu810575ow")
const MED_LAB_LAB = preload("uid://bh684ottuq0dm")

# Factory
const FACTORY_BREAKROOM = preload("uid://c17706sfsqwgg")
const FACTORY_COURT_YARD = preload("uid://cqka4jvwvf0lq")
const FACTORY_ENTRANCE_HALL = preload("uid://bmxl3fqn8abar")
const FACTORY_FUEL_ROOM = preload("uid://bd1tcqo4uicd7")
const FACTORY_MEAT_FACTORY = preload("uid://bnwb6wnqkkqqa")
const FACTORY_RESTROOM = preload("uid://da12pri7qrqxl")
const FACTORY_STORAGE_HALL = preload("uid://c2ya3lwwo824t")
const FACTORY_WORK_AREA_1 = preload("uid://0q7vteyoueaa")
const FACTORY_WORK_AREA_2 = preload("uid://c5w3u46rrv2jx")

var spawnDoorTag

func ChangeMap(mapName, doorName):
	var mapToLoad
	match mapName:
		"LOST_CITY":
			mapToLoad = LOST_CITY
		"LOST_TOWN":
			mapToLoad = LOST_TOWN
		"RAT_ROOM":
			mapToLoad = RAT_ROOM
		"TOWER_APARTMENTS":
			mapToLoad = TOWER_APARTMENTS
		"TOWER_BALCONY":
			mapToLoad = TOWER_BALCONY
		"TOWER_LOBBY":
			mapToLoad = TOWER_LOBBY
		"TOWER_MEATLOCKER":
			mapToLoad = TOWER_MEATLOCKER
		"TOWER_STAIRWAY_1":
			mapToLoad = TOWER_STAIRWAY_1
		"TOWER_STAIRWAY_2":
			mapToLoad = TOWER_STAIRWAY_2
		"MISC_ROOMS_MAP":
			mapToLoad = MISC_ROOMS_MAP
		"SEWER_CAI_HALL":
			mapToLoad = SEWER_CAI_HALL
		"SEWER_PUZZLE_ROOM":
			mapToLoad = SEWER_PUZZLE_ROOM
		"SUBMARINE_DOCK":
			mapToLoad = SUBMARINE_DOCK
		"FACTORY_WORK_AREA_2":
			mapToLoad = FACTORY_WORK_AREA_2
		"FACTORY_WORK_AREA_1":
			mapToLoad = FACTORY_WORK_AREA_1
		"FACTORY_STORAGE_HALL":
			mapToLoad = FACTORY_STORAGE_HALL
		"FACTORY_RESTROOM":
			mapToLoad = FACTORY_RESTROOM
		"FACTORY_MEAT_FACTORY":
			mapToLoad = FACTORY_MEAT_FACTORY
		"FACTORY_FUEL_ROOM":
			mapToLoad = FACTORY_FUEL_ROOM
		"FACTORY_ENTRANCE_HALL":
			mapToLoad = FACTORY_ENTRANCE_HALL
		"FACTORY_COURT_YARD":
			mapToLoad = FACTORY_COURT_YARD
		"FACTORY_BREAKROOM":
			mapToLoad = FACTORY_BREAKROOM
		"MED_LAB_LAB":
			mapToLoad = MED_LAB_LAB
		"MEDICAL_LAB":
			mapToLoad = MEDICAL_LAB
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
