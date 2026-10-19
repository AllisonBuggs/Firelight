extends NPCClass

func _ready() -> void:
	start()
	animation_walk_up = "Issac_WalkUp"
	animation_walk_left= "Issac_WalkLeft"
	animation_walk_right = "Issac_WalkRight"
	animation_walk_down = "Issac_WalkDown"
	animated_sprite_2d.play("Issac_WalkDown")
