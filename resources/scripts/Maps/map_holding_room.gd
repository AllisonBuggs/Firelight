extends allMaps
@onready var door_l: Area2D = $Objects/doorL
@onready var door_r: Area2D = $Objects/doorR

@onready var TI1: Sprite2D = $throwable_item
var ozz_top : Vector2 = Vector2(0,0)

func _ready() -> void:
	throwable_objects = [TI1]
	setUpMap()

func closestPlayerApproach():
	pass
