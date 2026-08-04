extends Node2D
class_name Mirror

@export var character : Node
@onready var player_reflection: Sprite2D = $puddle_fill/PlayerReflection

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var distance_y = character.global_position.y - global_position.y
	
	player_reflection.global_position = Vector2(character.global_position.x,global_position.y + distance_y)
