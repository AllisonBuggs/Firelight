extends MarginContainer

@onready var saveButton = $Panel/MarginContainer/HBoxContainer/SavesButton
@warning_ignore("unused_signal")
signal resumeButtonPressed
@warning_ignore("unused_signal")
signal settingsButtonPressed
@warning_ignore("unused_signal")
signal saveButtonPressed

func _ready() -> void:
	GlobalSignalBus.connect("pauseOpened", recived_pauseOpened)

func _on_resume_button_pressed() -> void:
	GlobalSignalBus.emit_signal("resumeButtonPressed")
	GlobalSignalBus.emit_signal("changeMouseToCrossHair")

func _on_settings_button_pressed() -> void:
	GlobalSignalBus.emit_signal("settingsButtonPressed")


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://resources/scenes/main_menu.tscn")


func _on_saves_button_pressed() -> void:
	GlobalSignalBus.emit_signal("saveButtonPressed")

func recived_pauseOpened():
	saveButton.grab_focus()
	print("wdead")
	GlobalSignalBus.emit_signal("changeMouseToSelect")


func _on_resume_button_mouse_entered() -> void:
	$Panel/MarginContainer/HBoxContainer/ResumeButton.grab_focus()


func _on_resume_button_mouse_exited() -> void:
	$Panel/MarginContainer/HBoxContainer/ResumeButton.release_focus()


func _on_saves_button_mouse_entered() -> void:
	$Panel/MarginContainer/HBoxContainer/SavesButton.grab_focus()


func _on_saves_button_mouse_exited() -> void:
	$Panel/MarginContainer/HBoxContainer/SavesButton.release_focus()


func _on_settings_button_mouse_entered() -> void:
	$Panel/MarginContainer/HBoxContainer/SettingsButton.grab_focus()


func _on_settings_button_mouse_exited() -> void:
	$Panel/MarginContainer/HBoxContainer/SettingsButton.release_focus()


func _on_exit_button_mouse_entered() -> void:
	$Panel/MarginContainer/HBoxContainer/ExitButton.grab_focus()


func _on_exit_button_mouse_exited() -> void:
	$Panel/MarginContainer/HBoxContainer/ExitButton.release_focus()
