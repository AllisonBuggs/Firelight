extends NPCClass

func _ready() -> void:
	start()
	animation_walk_up = "natalie_walk_up"
	animation_walk_left= "natalie_walk_left"
	animation_walk_right = "natalie_walk_right"
	animation_walk_down = "natalie_walk_down"
	animated_sprite_2d.play("natalie_walk_down")
