extends Node


var tilemaps: Array[TileMapLayer] = []

const footstep_sounds = {
	"carpet": [
		preload("res://resources/sfx/footsteps/CarpetWalk_01.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_02.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_03.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_04.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_05.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_06.wav"),
		preload("res://resources/sfx/footsteps/CarpetWalk_07.wav"),
	],
	"tile": [
		preload("res://resources/sfx/footsteps/TileWalk_05.wav"),
		preload("res://resources/sfx/footsteps/TileWalk_06.wav"),
		preload("res://resources/sfx/footsteps/TileWalk_07.wav"),
	],
	"metal": [
		preload("res://resources/sfx/footsteps/MetalWalk_1.wav"),
		preload("res://resources/sfx/footsteps/MetalWalk_2.wav"),
		preload("res://resources/sfx/footsteps/MetalWalk_3.wav"),
		preload("res://resources/sfx/footsteps/MetalWalk_4.wav"),
	],
	"grass": [
		preload("res://resources/sfx/footsteps/GrassWalk_21.wav"),
		preload("res://resources/sfx/footsteps/GrassWalk_22.wav"),
		preload("res://resources/sfx/footsteps/GrassWalk_23.wav"),
	],
	"rock": [
		preload("res://resources/sfx/footsteps/RockWalk_07.wav"),
		preload("res://resources/sfx/footsteps/RockWalk_08.wav"),
		preload("res://resources/sfx/footsteps/RockWalk_09.wav"),
	],
	"wood": [
		preload("res://resources/sfx/footsteps/WoodWalk_01.wav"),
		preload("res://resources/sfx/footsteps/WoodWalk_02.wav"),
		preload("res://resources/sfx/footsteps/WoodWalk_03.wav"),
	],
	"meat": [
		preload("res://resources/sfx/footsteps/FleshWalk1.wav"),
		preload("res://resources/sfx/footsteps/FleshWalk2.wav"),
		preload("res://resources/sfx/footsteps/FleshWalk3.wav"),
	]
}

func play_footstep(position: Vector2):
	var tile_data = []
	for tilemap in tilemaps:
		if is_instance_valid(tilemap):
			var tile_position = tilemap.local_to_map(position)
			var data = tilemap.get_cell_tile_data(tile_position)
			if data:
				tile_data.push_back(data)
		
		if tile_data.size() > 0:
			var tile_type = tile_data.back().get_custom_data("footstep_sound")
			
			if footstep_sounds.has(tile_type):
				var audio_player = AudioStreamPlayer2D.new()
				audio_player.stream = footstep_sounds[tile_type].pick_random()
				get_tree().root.add_child(audio_player)
				audio_player.global_position = position
				audio_player.play()
				await audio_player.finished
				audio_player.queue_free()
