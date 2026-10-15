extends Area2D

@export var limbHealth : int = 100

@warning_ignore("unused_parameter")
func hurt(_damage, player_vel : Vector2):
	GlobalSignalBus.emit_signal("hit_connected")
	limbHealth -= _damage
	if limbHealth <= 0:
		get_parent().removeLimb(name)
		queue_free()
	get_parent().updateHealthBar()
