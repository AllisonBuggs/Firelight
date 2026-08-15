extends allMaps

@onready var cai: NPCClass = $cai

var like_rain = false

func _ready() -> void:
	setUpMap()
	GlobalSignalBus.emit_signal("changeMusic", "NEW_HOME")
