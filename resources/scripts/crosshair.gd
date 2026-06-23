extends Sprite2D

func _ready() -> void:
	DialogueManager.connect("dialogue_started", dialogueStarted)
	DialogueManager.connect("dialogue_ended", dialogueEnded)
	
	GlobalSignalBus.connect("inventoryOpened", recived_inventoryOpened)
	GlobalSignalBus.connect("iventoryReturnButtonPressed", inventoryReturnButtonPressed)
	GlobalSignalBus.connect("changeMouseToSelect", changeMouseToSelect)
	GlobalSignalBus.connect("changeMouseToCrossHair", changeMouseToCrossHair)

func changeMouseToSelect():
	texture = load("res://resources/sprites/UI/CrosshairSelect.png")

func changeMouseToCrossHair(): 
	texture = load("res://resources/sprites/UI/crosshair043.png")

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	position = get_global_mouse_position()

@warning_ignore("unused_parameter")
func dialogueStarted(resource):
	
	texture = load("res://resources/sprites/UI/CrosshairSelect.png")

@warning_ignore("unused_parameter")
func dialogueEnded(resource):
	texture = load("res://resources/sprites/UI/crosshair043.png")

func recived_inventoryOpened():
	texture = load("res://resources/sprites/UI/CrosshairSelect.png")

func inventoryReturnButtonPressed():
	texture = load("res://resources/sprites/UI/crosshair043.png")
