extends RayCast2D

var alreadyHit = false
var overlappingObject
var damage
var player_owned = false

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if alreadyHit == false:
		if is_colliding():
			hurt()
	if is_colliding() == false:
		alreadyHit = false

func hurt():
	overlappingObject = get_collider()
	if get_collider().has_method("hurt"):
		deal_damage()

func deal_damage():
	overlappingObject.hurt(damage, get_parent().velocity)
	alreadyHit = true

func setup(parentDamage : int, player_owner : bool):
	damage = parentDamage
	player_owned = player_owner
