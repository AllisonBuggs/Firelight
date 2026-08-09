extends MarginContainer

@onready var resume_button: Button = $Panel/MarginContainer/HBoxContainer/ResumeButton
@onready var saves_button: Button = $Panel/MarginContainer/HBoxContainer/SavesButton
@onready var settings_button: Button = $Panel/MarginContainer/HBoxContainer/SettingsButton
@onready var exit_button: Button = $Panel/MarginContainer/HBoxContainer/ExitButton


@warning_ignore("unused_signal")
signal resumeButtonPressed
@warning_ignore("unused_signal")
signal settingsButtonPressed
@warning_ignore("unused_signal")
signal saveButtonPressed

func _ready() -> void:
	GlobalSignalBus.connect("pauseOpened", recived_pauseOpened)

func _on_resume_button_pressed() -> void:
	GlobalSignalBus.emit_signal("closeAllMenus")
	GlobalSignalBus.emit_signal("changeMouseToCrossHair")

func _on_settings_button_pressed() -> void:
	GlobalSignalBus.emit_signal("settingsButtonPressed")


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://resources/scenes/main_menu.tscn")
	GlobalSignalBus.emit_signal("closeAllMenus")


func _on_saves_button_pressed() -> void:
	GlobalSignalBus.emit_signal("saveButtonPressed")

func recived_pauseOpened():
	saves_button.grab_focus()
	print("wdead")
	GlobalSignalBus.emit_signal("changeMouseToSelect")


func _on_resume_button_mouse_entered() -> void:
	resume_button.grab_focus()


func _on_resume_button_mouse_exited() -> void:
	resume_button.release_focus()


func _on_saves_button_mouse_entered() -> void:
	saves_button.grab_focus()


func _on_saves_button_mouse_exited() -> void:
	saves_button.release_focus()


func _on_settings_button_mouse_entered() -> void:
	settings_button.grab_focus()


func _on_settings_button_mouse_exited() -> void:
	settings_button.release_focus()


func _on_exit_button_mouse_entered() -> void:
	exit_button.grab_focus()


func _on_exit_button_mouse_exited() -> void:
	exit_button.release_focus()
