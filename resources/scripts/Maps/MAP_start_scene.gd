extends Node2D

@onready var textanimationplayer = $AnimationPlayer

var currentUI = "intro"
var firstTime = SaveLoad.SaveFileData.firstTime

func _ready() -> void:
	if firstTime == true:
		textanimationplayer.play("FadeName")
	else:
		get_tree().change_scene_to_file("res://resources/scenes/main_menu.tscn")

func _on_button_2_pressed() -> void:
	textanimationplayer.play_backwards("FadeName")
	SaveLoad.SaveFileData.playerName = "David"
	textanimationplayer.queue("FadeIdentity")

func _on_button_pressed() -> void:
	textanimationplayer.play_backwards("FadeName")
	SaveLoad.SaveFileData.playerName = "Susie"
	textanimationplayer.queue("FadeIdentity")

func _on_button_3_pressed() -> void:
	textanimationplayer.play_backwards("FadeName")
	SaveLoad.SaveFileData.playerName = "Haven"
	textanimationplayer.queue("FadeIdentity")


func IdentitySelected() -> void:
	textanimationplayer.play_backwards("FadeIdentity")
	await textanimationplayer.animation_finished
	get_tree().change_scene_to_file("res://resources/scenes/maps/Intro.tscn")
