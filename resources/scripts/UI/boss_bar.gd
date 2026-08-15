extends TextureProgressBar

@onready var hurt_timer: Timer = $hurt_timer
@onready var boss_hp_label: Label = $boss_hp_label

const SHAKE_MATERIAL = preload("uid://dcm66d8l3bonq")
const TEXT_WAVE_MATERIAL = preload("uid://cqq42b74cdp15")

var t = 0
var current_health : int
var temp_health : int


func _ready() -> void:
	GlobalSignalBus.connect("update_boss_health_bar", bar_update)
	GlobalSignalBus.connect("set_bar_max", setup_max)

func setup_max(new_max : int):
	max_value = new_max

func bar_update(new_hp: int, old_hp : int):
	boss_hp_label.material = SHAKE_MATERIAL
	hurt_timer.start()
	current_health = new_hp
	temp_health = old_hp
	value = current_health
	t = 0

func _process(delta: float) -> void:
	if t < 1:
		t += delta * 4
		boss_hp_label.text = str(roundi(lerp(temp_health,current_health, t)))
	else:
		if temp_health != current_health:
			boss_hp_label.text = str(current_health)


func _on_hurt_timer_timeout() -> void:
	boss_hp_label.material = TEXT_WAVE_MATERIAL
