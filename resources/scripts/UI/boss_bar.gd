extends ProgressBar


func _ready() -> void:
	GlobalSignalBus.connect("update_boss_health_bar", bar_update)
	GlobalSignalBus.connect("set_bar_max", setup_max)

func setup_max(new_max : int):
	max_value = new_max

func bar_update(new_hp: int):
	value = new_hp
