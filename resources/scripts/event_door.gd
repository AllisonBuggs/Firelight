extends Event
class_name Door

@export var mapToLoad = ""
@export var entranceUsed = ""
@onready var Spawn = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print(mapToLoad, entranceUsed)
		GlobalSignalBus.emit_signal("playerMovement", false)
		GlobalSignalBus.call_deferred("ChangeMap", mapToLoad, entranceUsed)
