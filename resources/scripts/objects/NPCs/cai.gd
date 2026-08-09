extends NPCClass

func _ready() -> void:
	start()
	animation_walk_up = "Cai_Masked_Walk_Up"
	animation_walk_left= "Cai_Masked_Walk_Left"
	animation_walk_right = "Cai_Masked_Walk_Right"
	animation_walk_down = "Cai_Masked_Walk_Down"
	animated_sprite_2d.play("Cai_Masked_Walk_Down")
