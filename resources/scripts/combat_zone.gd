extends Event

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		state = "Combat"
		target = "Player"
		GlobalSignalBus.emit_signal("playerEnteredCombat", target, state)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		state = "None"
		GlobalSignalBus.emit_signal("playerEnteredCombat", target, state)
