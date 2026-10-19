extends NPCClass

func _ready() -> void:
	start()
	animation_walk_up = "feral_walk_up"
	animation_walk_left= "feral_walk_left"
	animation_walk_right = "feral_walk_right"
	animation_walk_down = "feral_walk_down"
	animated_sprite_2d.play("feral_walk_down")
