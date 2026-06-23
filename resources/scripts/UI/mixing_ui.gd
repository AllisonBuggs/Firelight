extends Control

var currentMixture = ""
var mixtureNumuricalResult = 1
var NumricalMixture : Array

#Mixing Buttons
@onready var MixA = $CenterContainer/MainPanel/ComponetsButtons/MixA
@onready var MixB = $CenterContainer/MainPanel/ComponetsButtons/MixB
@onready var MixC = $CenterContainer/MainPanel/ComponetsButtons/MixC
@onready var MixD = $CenterContainer/MainPanel/ComponetsButtons/DisfunctionalD
@onready var MixE = $CenterContainer/MainPanel/ComponetsButtons/MixE
#Flask Buttons
@onready var TakeFlaskButton = $CenterContainer/MainPanel/ButtomRowButtons/TakeFlash
@onready var DumpMixtureButton = $"CenterContainer/MainPanel/ButtomRowButtons/Dump Mixture"
#Extra
@onready var audioPlayer = $AudioStreamPlayer
@onready var MixtureLabel = $CenterContainer/MainPanel/Flask/CenterContainer/MixtureLabel

func _on_mix_a_pressed() -> void:
	currentMixture += "A"
	MixtureLabel.text = currentMixture
	NumricalMixture.append(1)
	pourNoise()

func _on_mix_b_pressed() -> void:
	currentMixture += "B"
	MixtureLabel.text = currentMixture
	NumricalMixture.append(2)
	pourNoise()

func _on_mix_c_pressed() -> void:
	currentMixture += "C"
	NumricalMixture.append(3)
	MixtureLabel.text = currentMixture
	pourNoise()

func _on_disfunctional_d_pressed() -> void:
	audioPlayer.stream = load("res://resources/sfx/spring strung 12.wav")
	audioPlayer.play()

func _on_mix_e_pressed() -> void:
	currentMixture += "E"
	NumricalMixture.append(5)
	MixtureLabel.text = currentMixture
	pourNoise()

func pourNoise():
	audioPlayer.stream = load("res://resources/sfx/liquid pouring 6.wav")
	audioPlayer.play()

func _on_dump_mixture_pressed() -> void:
	currentMixture = ""
	MixtureLabel.text = currentMixture

func _on_take_flash_pressed() -> void:
	audioPlayer.stream = load("res://resources/sfx/glass taken off shelf 4.wav")
	audioPlayer.play()
	hide()
	for k in NumricalMixture:
		mixtureNumuricalResult *= k
		print(mixtureNumuricalResult)
	if mixtureNumuricalResult == 96:
		print("Correct!")
		GlobalSignalBus.emit_signal("container_data", "FleshBurningMixture")
	else:
		GlobalSignalBus.emit_signal("container_data", "Mixture")
	GlobalSignalBus.emit_signal("playerMovement", true)
	currentMixture = ""
	mixtureNumuricalResult = 1
	NumricalMixture.clear()
	MixtureLabel.text = currentMixture


func _on_button_pressed() -> void:
	GlobalSignalBus.emit_signal("playerMovement", true)
	hide()
