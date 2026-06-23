extends Control

@onready var keyPad1: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons/1"
@onready var keyPad2: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons/2"
@onready var keyPad3: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons/3"
@onready var keyPad4: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons2/4"
@onready var keyPad5: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons2/5"
@onready var keyPad6: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons2/6"
@onready var keyPad7: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons3/7"
@onready var keyPad8: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons3/8"
@onready var keyPad9: Button = $"CenterContainer/MarginContainer/Keypad/VBoxContainer/VBoxContainer/ComponetsButtons3/9"

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var input : Array

func _on_key_pad_1_pressed() -> void:
	keypadPressSound()
	input.append(1)

func _on_key_pad_2_pressed() -> void:
	keypadPressSound()
	input.append(2)

func _on_key_pad_3_pressed() -> void:
	keypadPressSound()
	input.append(3)

func _on_key_pad_4_pressed() -> void:
	keypadPressSound()
	input.append(4)

func _on_key_pad_5_pressed() -> void:
	keypadPressSound()
	input.append(5)

func _on_key_pad_6_pressed() -> void:
	keypadPressSound()
	input.append(6)

func _on_key_pad_7_pressed() -> void:
	keypadPressSound()
	input.append(7)

func _on_key_pad_8_pressed() -> void:
	keypadPressSound()
	input.append(8)

func _on_key_pad_9_pressed() -> void:
	keypadPressSound()
	input.append(9)

func keypadPressSound():
	audio_stream_player.stream = load("res://resources/sfx/old cell phone button press 1.wav")
	audio_stream_player.play()

func _on_back_button_pressed() -> void:
	hide()
