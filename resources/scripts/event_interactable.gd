extends Node

@export var textToDisplay : String
@export var oneTime : bool


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalSignalBus.emit_signal("interactableData", textToDisplay, "none", "You")
