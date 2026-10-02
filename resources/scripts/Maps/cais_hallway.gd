extends allMaps

func _ready() -> void:
	setUpMap()
	#GlobalSignalBus.emit_signal("changeMusic", "NEW_HOME")
	doors.set("bedroomdoor_r", $Objects/bedroomdoor_r)
	doors.set("bedroomdoor_l", $Objects/bedroomdoor_l)
