extends Event

class_name Door


@export var mapToLoad = ""
@export var entranceUsed = ""
@export var direction = ""
@onready var Spawn = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalSignalBus.call_deferred("ChangeMap", mapToLoad, entranceUsed)
