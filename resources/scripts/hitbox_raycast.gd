extends RayCast2D

var alreadyHit = false
var overlappingObject
var damage

func _ready() -> void:
	GlobalSignalBus.connect("attackRaycastInitiate", setup)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if alreadyHit == false:
		if is_colliding():
			hit()
	if is_colliding() == false:
		alreadyHit = false

func hit():
	overlappingObject = get_collider()
	if overlappingObject is TileMapLayer or overlappingObject == null or overlappingObject is Area2D:
		pass
	else:
		overlappingObject.hurt(damage)
		alreadyHit = true

func setup(parentDamage):
	damage = parentDamage
