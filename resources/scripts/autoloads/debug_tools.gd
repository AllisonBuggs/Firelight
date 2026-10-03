extends Node

const LEAP = preload("uid://btn7claay00lb")
const OPEN = preload("uid://bm7hev4ranqr1")

@export var player : Player
@export var title : String
@onready var user_interface: Control = $User_Interface

@onready var cutscene_box: VBoxContainer = $User_Interface/ScrollContainer/VBoxContainer


var active : bool = true
var Cutscenes_Folder : String = "res://resources/dialogue/"

const CutsceneButton = preload("uid://can0lw3qch5df")
const FLAG_EDIT = preload("uid://cabh1wscrtqll")

func _ready() -> void:
	toggle_activity()

func play_sound(sound):
	var aud_player = AudioStreamPlayer.new()
	add_child(aud_player)
	aud_player.stream = sound
	aud_player.play()
	await aud_player.finished
	aud_player.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_released("DEBUG_NOCLIP"):
		play_sound(LEAP)
		player.toggle_noclip()
	if event.is_action_released("DEBUG_open"):
		play_sound(OPEN)
		toggle_activity()

func toggle_activity():
	active = !active
	if active:
		user_interface.show()
		populate_cutscenebuttons()
	else:
		user_interface.hide()
		var allbuttons = cutscene_box.get_children()
		for child in allbuttons:
				child.queue_free()

func populate_cutscenebuttons():
	var script : Resource = SaveLoad.SaveFileData
	var variables = script.get_property_list()
	variables = variables.slice(9)
	for info in variables:

		var prop_name = info.name
		var prop_value = script.get(prop_name)
		var button = FLAG_EDIT.instantiate()
		cutscene_box.add_child(button)

		button.label.text = prop_name
		button.line_edit.text = str(prop_value)

		button.prop_name = prop_name
		button.prop_value = prop_value
