extends Node

const save_location1 = "user://Save1.tres"
const save_location2 = "user://Save2.tres"
const save_location3 = "user://Save3.tres"

var SaveFileData: SaveDataResource = SaveDataResource.new()

var save_location

func returnSaveSlot(slot):
	match slot:
		1: return  save_location1
		2: return  save_location2
		3: return save_location3

func _save(slot):
	save_location = returnSaveSlot(slot)
	var ec = ResourceSaver.save(SaveFileData, save_location)
	print(error_string(ec))

func _load(slot):
	save_location = returnSaveSlot(slot)
	if FileAccess.file_exists(save_location):
		print("ITS ALIVEEE")
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)

func _delete(slot):
	save_location = returnSaveSlot(slot)
	if FileAccess.file_exists(save_location):
		OS.move_to_trash(ProjectSettings.globalize_path(save_location))
