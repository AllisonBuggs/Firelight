extends Area2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("Flicker In")
		point_light_2d.show()
		audio_stream_player.stream = load("res://resources/sfx/Common/spring strung light 3.wav")
		audio_stream_player.play()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		animation_player.play_backwards("Flicker Out")
		audio_stream_player.stream = load("res://resources/sfx/Common/spring strung light 4.wav")
		audio_stream_player.play()
