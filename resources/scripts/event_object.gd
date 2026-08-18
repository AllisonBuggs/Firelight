@tool
extends StaticBody2D

@export var selected_sprite = Resource

@onready var sprite: Sprite2D = $sprite


func _ready() -> void:
	sprite.texture = selected_sprite
