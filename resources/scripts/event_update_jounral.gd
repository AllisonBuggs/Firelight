extends Area2D

@export var journalName : String
@export var manualTrigger : bool = false
@export var removeEntry : bool = false
@export var onlyOnce: bool = true

func _ready() -> void:
	if manualTrigger == false:
		collision_layer = 1
		collision_mask = 1

func _on_body_entered(body: Node2D) -> void:
	if manualTrigger == false:
		if body is Player:
			GlobalSignalBus.emit_signal("updateJounral", journalName)
			if onlyOnce == true:
				queue_free()

func action():
	GlobalSignalBus.emit_signal("updateJounral", journalName)
	if onlyOnce == true:
		queue_free()
