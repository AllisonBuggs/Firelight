extends Node2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://resources/scenes/scene_change.tscn")
