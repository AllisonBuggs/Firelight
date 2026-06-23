extends Node2D
class_name Mirror

@export var character : Node

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var distance_y = character.global_position.y - global_position.y
	
	$PlayerReflection.global_position = Vector2(character.global_position.x,global_position.y + distance_y)
