extends Node

const LEAP = preload("uid://btn7claay00lb")

@export var player : Player

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
