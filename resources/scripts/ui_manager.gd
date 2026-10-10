extends Control

var currentUi = "none"
var toggle = false

@onready var combatUI: Control = $CanvasLayer/CombatUi
@onready var saveloadMenu: Control = $CanvasLayer/saveAndLoadMenu
@onready var settings: Panel = $CanvasLayer/Settings
@onready var pauseMenu: MarginContainer = $CanvasLayer/PauseMenu
@onready var inventory: Control = $CanvasLayer/Inventory
@onready var journal: Control = $CanvasLayer/StorySummary

func _ready() -> void:
	pauseMenu.hide()
	GlobalSignalBus.connect("closeAllMenus", closeAllMenus)
	GlobalSignalBus.connect("settingsButtonPressed", recived_settingsButtonPressed)
	GlobalSignalBus.connect("saveButtonPressed", recived_saveButtonPressed)
	GlobalSignalBus.connect("returnButtonPressed", recived_returnButtonPressed)
	GlobalSignalBus.connect("iventoryReturnButtonPressed", recived_iventoryReturnButtonPressed)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("open_menu"):
		if currentUi != "inventory":
			toggle =! toggle
			if toggle == true:
				match currentUi:
					"none":
						pauseMenu.show()
						get_tree().paused = true
						currentUi = "main"
						GlobalSignalBus.emit_signal("pauseOpened")
						Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					"settings":
						pauseMenu.show()
						settings.hide()
						currentUi = "main"
					"saveloadMenu":
						pauseMenu.show()
						saveloadMenu.hide()
						currentUi = "main"
					
			if toggle == false:
				match currentUi:
					"main": 
						pauseMenu.hide()
						get_tree().paused = false
						currentUi = "none"
						Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if event.is_action_released("inventory_key"):
		toggle =! toggle
		if currentUi == "none":
			if toggle == true:
				inventory.show()
				GlobalSignalBus.emit_signal("inventoryOpened")
				get_tree().paused = true
				currentUi = "inventory"
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if currentUi == "inventory":
			if toggle == false:
				GlobalSignalBus.emit_signal("iventoryReturnButtonPressed")
				inventory.hide()
				get_tree().paused = false
				currentUi = "none"
				Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if event.is_action_released("openJournalKey"):
		toggle =! toggle
		if currentUi == "none":
			if toggle == true:
				journal.show()
				GlobalSignalBus.emit_signal("journalOpened")
				get_tree().paused = true
				currentUi = "journal"
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if currentUi == "journal":
			if toggle == false:
				journal.hide()
				get_tree().paused = false
				currentUi = "none"
				Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func closeAllMenus():
	journal.hide()
	pauseMenu.hide()
	saveloadMenu.hide()
	settings.hide()
	get_tree().paused = false
	currentUi = "none"
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	toggle =! toggle


func recived_settingsButtonPressed():
	currentUi = "settings"
	pauseMenu.hide()
	settings.show()
	GlobalSignalBus.emit_signal("settingsOpened")
	toggle =! toggle

func recived_saveButtonPressed():
	currentUi = "saveloadMenu"
	pauseMenu.hide()
	GlobalSignalBus.emit_signal("saveloadMenuOpened")
	saveloadMenu.show()
	toggle =! toggle

func recived_returnButtonPressed():
	currentUi = "main"
	pauseMenu.show()
	saveloadMenu.hide()
	settings.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	toggle =! toggle
	GlobalSignalBus.emit_signal("pauseOpened")
	
func recived_iventoryReturnButtonPressed():
	inventory.hide()
	get_tree().paused = false
	currentUi = "none"
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
