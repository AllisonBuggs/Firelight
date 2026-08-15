extends Node2D

@onready var SFXStream = $UIstreamSFX
@onready var background = $NoelleIsTheGoat
@onready var eyeTransition = $EyeShilloute
@onready var eyeAnimationPlayer = $AnimationPlayer
@onready var MainMenu = $MainMenu
@onready var Settings = $Settings
@onready var SaveLoadMenu = $SaveLoadMenu
@onready var newGameMenu = $Start
@onready var difficultySelectionButton = $Start/VBoxContainer/VBoxContainer/DifficultySelection
@onready var extrasSelectionButton = $Start/VBoxContainer/VBoxContainer2/ExtrasSelection
@onready var MIT = $mouseIdleTimer
@onready var newGameButton = $MainMenu/MarginContainer2/VBoxContainer2/newGameButton
@onready var settingsButton = $MainMenu/MarginContainer2/VBoxContainer2/SettingsButton
@onready var savesButton = $MainMenu/MarginContainer2/VBoxContainer2/SavesButton
@onready var exitButton = $MainMenu/MarginContainer2/VBoxContainer2/ExitButton

var hoverTheme = load("res://resources/styles/mainmenuthemebutoons.tres")
var MouseIdleTime 
var buttonWithFocus = newGameButton
var mousePosition
var nextScreen
var screenToHide
var difficultySelection = 2
var extraSelection = 0

func _ready() -> void:
	GlobalSignalBus.connect("returnButtonPressed", backPressed)
	savesButton.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GlobalSignalBus.emit_signal("changeMusic", "MAIN_THEME")
	GlobalMusicPlayer.play()

func checkMousePosition():
	GlobalSignalBus.emit_signal("mouseTimeOut", true)

func _on_new_game_button_pressed() -> void:
	transition_IN()
	nextScreen = "newGame"

func _on_exit_button_pressed() -> void:
	eyeAnimationPlayer.play("transitionIn")
	nextScreen = "exit"

func _on_saves_button_pressed() -> void:
	nextScreen = "saves"
	transition_IN()

func _on_settings_button_pressed() -> void:
	nextScreen = "settings"	
	transition_IN()

func transition_IN():
	eyeAnimationPlayer.play("transitionIn")
	eyeAnimationPlayer.queue("transitionOut")
	SFXStream.pitch_scale = randf_range(1,1.5)
	SFXStream.play()


@warning_ignore("unused_parameter")
func _on_animation_player_animation_changed(old_name: StringName, new_name: StringName) -> void:
	if eyeAnimationPlayer.current_animation == "transitionOut" && eyeAnimationPlayer.animation_started:
		print("this")
		match nextScreen:
			"start":
				Settings.hide()
				MainMenu.hide()
				SaveLoadMenu.hide()
				newGameMenu.show()
			"settings":
				SaveLoadMenu.hide()
				MainMenu.hide()
				Settings.show()
			"saves":
				SaveLoadMenu.show()
				MainMenu.hide()
				Settings.hide()
			"main":
				SaveLoadMenu.hide()
				MainMenu.show()
				Settings.hide()
				newGameMenu.hide()
			"newGame": 
				SaveLoadMenu.hide()
				MainMenu.hide()
				Settings.hide()
				newGameMenu.hide()
				newGameMenu.show()

func backPressed():
	nextScreen = "main"
	transition_IN()

func _on_start_button_pressed() -> void:
	eyeAnimationPlayer.play("transitionIn")
	nextScreen = "start"	

@warning_ignore("unused_parameter")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match nextScreen:
		"exit":
			get_tree().quit()
		"start":
			$slowtransitiontogame.start()
			GlobalMusicPlayer.fadeMusic(true)

func _on_difficulty_selection_pressed() -> void:
	difficultySelection += 1
	match difficultySelection:
		1:difficultySelectionButton.text = "Easy"
		2:difficultySelectionButton.text = "Normal"
		3:difficultySelectionButton.text = "Hard"
		4:difficultySelectionButton.text = "HARD ++"
		5:
			difficultySelection = 1
			difficultySelectionButton.text = "Easy"


func _on_extras_selection_pressed() -> void:
	extraSelection += 1
	match extraSelection:
		0:extrasSelectionButton.text = "None"
		1:extrasSelectionButton.text = "Devloper Commentary"
		2:
			extraSelection = 0
			extrasSelectionButton.text = "None"


func _on_mouse_idle_timer_timeout() -> void:
	if mousePosition == get_global_mouse_position():
		GlobalSignalBus.emit_signal("mouseTimeOut", false)


func _on_slowtransitiontogame_timeout() -> void:
	get_tree().change_scene_to_file("res://resources/scenes/maps/Intro.tscn")
