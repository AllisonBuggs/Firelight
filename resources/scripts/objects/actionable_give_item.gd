extends Area2D

@export var itemToGiveID : String = ""
@export var dialogFile : DialogueResource
@export var giveItemDialog : DialogueResource
@export var dialogStart : String= "start" 

var toggle = false

func action():
	if toggle == true:
		DialogueManager.show_example_dialogue_balloon(dialogFile, dialogStart)
	else:
		DialogueManager.show_example_dialogue_balloon(giveItemDialog, dialogStart)
		GlobalSignalBus.emit_signal("container_data", itemToGiveID)
		toggle = true
