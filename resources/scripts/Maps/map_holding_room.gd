extends allMaps

@onready var TI1: Sprite2D = $throwable_item

func _ready() -> void:
	throwable_objects = [TI1]
	setUpMap()
