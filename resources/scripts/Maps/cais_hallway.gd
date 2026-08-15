extends allMaps

func _ready() -> void:
	setUpMap()
	GlobalSignalBus.emit_signal("changeMusic", "NEW_HOME")
