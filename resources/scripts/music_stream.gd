extends AudioStreamPlayer2D

func changeMusic(streamPath: String):
	stream = load(streamPath)
	play()
