extends Control

@onready var transition_player: AnimationPlayer = $CanvasLayer/transition_player

func _ready() -> void:
	GlobalSignalBus.connect("play_transition", play_transition)
	GlobalSignalBus.connect("change_scene_with_transition", change_scene)

func change_scene():
	play_transition(false)
	await transition_player.animation_finished
	play_transition(true)
	
func play_transition(backwards : bool):
	if backwards:
		transition_player.play_backwards("transition")
	else:
		transition_player.play("transition")
