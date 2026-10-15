extends boss_class

func _ready() -> void:

	idle_available = ["walk_into", "idle_protect_self"]
	attacks_avilable = ["approach_swipe", "dash", "throw_object"]
	recovery_available = ["pant", "roar"]
	animation_walk_up = "jug_walk_up"
	animation_walk_left= "jug_walk_side"
	animation_walk_right = "jug_walk_side"
	animation_walk_down = "jug_walk_down"
	animations.append("jug_swipe_up")
	animations.append("jug_swipe_side")
	animations.append("jug_swipe_down")
	animations.append("jug_pant")
	
	default_movement_speed = 40
	attack_dmg = 20
	health = 1000
	
	setup()
	start()
	
	GlobalSignalBus.emit_signal("set_bar_max", health)
	GlobalSignalBus.emit_signal("update_boss_health_bar", health, 0)
	choose_random_action(idle_available)
	animated_sprite_2d.play(animation_walk_down)
