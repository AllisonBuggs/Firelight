extends Control

@onready var returnButton = $HBoxContainer/returnButton
@onready var save_button: Button = $HBoxContainer/SaveButton
@onready var load_button: Button = $HBoxContainer/LoadButton
@onready var delete_button: Button = $HBoxContainer/deleteButton

@onready var save1_name_label: Label = $MarginContainer/VBoxContainer/save/HBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/nameLabel
@onready var save1_completion_label: Label = $MarginContainer/VBoxContainer/save/HBoxContainer/CompletionLabel
@onready var save1_time_label: Label = $MarginContainer/VBoxContainer/save/HBoxContainer/MarginContainer3/TimeLabel

@onready var save2_name_label: Label = $MarginContainer/VBoxContainer/save2/HBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/nameLabel
@onready var save2_completion_label: Label = $MarginContainer/VBoxContainer/save2/HBoxContainer/CompletionLabel
@onready var save2_time_label: Label = $MarginContainer/VBoxContainer/save2/HBoxContainer/MarginContainer3/TimeLabel

@onready var save3_name_label: Label = $MarginContainer/VBoxContainer/save3/HBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/nameLabel
@onready var save3_completion_label: Label = $MarginContainer/VBoxContainer/save3/HBoxContainer/CompletionLabel
@onready var save3_time_label: Label = $MarginContainer/VBoxContainer/save3/HBoxContainer/MarginContainer3/TimeLabel

@warning_ignore("unused_signal")
signal returnButtonPressed

var mode = "save"

func _ready() -> void:
	GlobalSignalBus.connect("saveloadMenuOpened", recived_saveloadMenuOpened)
	updateSaveInfo()
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name == "Main Menu":
		$HBoxContainer/SaveButton.hide()
		mode = "load"
		save_button.button_pressed = false
		load_button.button_pressed = true

func buttonPressed(slot):
	match mode: 
		"save":
			SaveLoad.SaveFileData.current_map = get_tree().current_scene.name
			SaveLoad.SaveFileData.player_position = Player.instance.global_position
			SaveLoad._save(slot)
			print("save")
		"load":
			SaveLoad._load(slot)
			GlobalSignalBus.call_deferred("ChangeMap", SaveLoad.SaveFileData.current_map, null)
			GlobalSignalBus.emit_signal("closeAllMenus")
			print("loading")
		"delete":
			SaveLoad._delete(slot)
			print("delete")
	updateSaveInfo()

func updateSaveInfo():
	if FileAccess.file_exists(SaveLoad.save_location1):
		var save_1_data = ResourceLoader.load(SaveLoad.save_location1).duplicate(true)
		save1_name_label.text = save_1_data.playerName
	else:
		save1_name_label.text = "Empty"
	if FileAccess.file_exists(SaveLoad.save_location2):
		var save_2_data = ResourceLoader.load(SaveLoad.save_location2).duplicate(true)
		save2_name_label.text = save_2_data.playerName
	else:
		save2_name_label.text = "Empty"
	if FileAccess.file_exists(SaveLoad.save_location3):
		var save_3_data = ResourceLoader.load(SaveLoad.save_location3).duplicate(true)
		save3_name_label.text = save_3_data.playerName
	else:
		save3_name_label.text = "Empty"

func _on_return_button_pressed() -> void:
	GlobalSignalBus.emit_signal("returnButtonPressed")

func _on_save_pressed() -> void:
	buttonPressed(1)

func _on_save_2_pressed() -> void:
	buttonPressed(2)

func _on_save_3_pressed() -> void:
	buttonPressed(3)

func recived_saveloadMenuOpened():
	returnButton.grab_focus()

func _on_return_button_mouse_entered() -> void:
	returnButton.grab_focus()

func _on_return_button_mouse_exited() -> void:
	returnButton.release_focus()

func _on_save_button_mouse_entered() -> void:
	save_button.grab_focus()

func _on_save_button_mouse_exited() -> void:
	save_button.release_focus()

func _on_load_button_mouse_entered() -> void:
	load_button.grab_focus()

func _on_load_button_mouse_exited() -> void:
	load_button.release_focus()

func _on_load_button_pressed() -> void:
	mode = "load"
	save_button.button_pressed = false
	load_button.button_pressed = true
	delete_button.button_pressed = false

func _on_save_button_pressed() -> void:
	mode = "save"
	load_button.button_pressed = false
	save_button.button_pressed = true
	delete_button.button_pressed = false

func _on_delete_button_mouse_entered() -> void:
	delete_button.grab_focus()


func _on_delete_button_mouse_exited() -> void:
	delete_button.release_focus()


func _on_delete_button_pressed() -> void:
	mode = "delete"
	load_button.button_pressed = false
	save_button.button_pressed = false
	delete_button.button_pressed = true
