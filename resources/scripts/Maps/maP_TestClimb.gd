extends Node2D

@onready var wind_timer: Timer = $wind_timer
@onready var wind_stream_player: AudioStreamPlayer = $wind_stream_player
@onready var player: CharacterBody2D = $player



func _on_wind_timer_timeout() -> void:
	var wind_direction = randi_range(1,2)
	if wind_direction == 2:
		player.end_wind()
	else:
		wind_direction = randi_range(1,2)
		player.wind_blow(wind_direction)
		wind_stream_player.play()
	wind_timer.start(randi_range(5,7))
