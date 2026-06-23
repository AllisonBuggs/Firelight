extends Button

func _pressed() -> void:
	if button_up:
		get_tree().change_scene_to_file("res://resources/scenes/main_menu.tscn")
