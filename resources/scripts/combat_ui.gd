extends Control

@export var staminaCooldown = 0.5

@onready var hp_display: Label = $HealthDisplaySprite/VBoxContainer/HP_Display
@onready var timer = $Timer
@onready var stamina_bar: ProgressBar = $stamina_bar
@onready var AnimationPlayerTree = $AnimationTree

@onready var heart_beat_player: AudioStreamPlayer = $heart_beat_player
@onready var text_color_tree: AnimationTree = $HealthDisplaySprite/text_color_tree

const HEART_BEAT_1 = preload("uid://dhimcipakqmar")
const HEART_BEAT_2 = preload("uid://wga2tiu7xwgx")
const HEART_BEAT_3 = preload("uid://qkd1wy6hwqgc")

var rand_gen = RandomNumberGenerator.new()

var player = SaveLoad.SaveFileData
var isInCombat : bool = false

var t = 0.0
var health_temp : int

func _ready() -> void:
	GlobalSignalBus.connect("playerEnteredCombat", toggleState)
	GlobalSignalBus.connect("updatePlayerHealth", health_update)
	GlobalSignalBus.connect("updatePlayerStamina", stamina_update)
	stamina_bar.hide()
	hp_display.hide()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if t < 1:
		t += delta * 4
		hp_display.text = str(roundi(lerp(health_temp,player.health, t)))
	else:
		if int(hp_display.text) != player.health:
			hp_display.text = str(player.health)

@warning_ignore("unused_parameter")
func toggleState(target: String, state: String):
	isInCombat = !isInCombat
	if isInCombat == true:
		stamina_bar.show()
		hp_display.show()
		AnimationPlayerTree.active = true
		AnimationPlayerTree.set("parameters/conditions/inCombat", true)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", false)
		timer.start(staminaCooldown)
	else: 
		AnimationPlayerTree.set("parameters/conditions/inCombat", false)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", true)

func stamina_update(_Stamina: int):
	if player.Stamina > 0:
		player.Stamina += _Stamina
		stamina_bar.value = player.Stamina
	else: 
		player.Stamina = 1 

func health_update(_Health: int):
	t = 0
	health_temp = player.health
	player.health += _Health
	text_color_tree.set("parameters/blend_position", player.health * 0.01)
	if player.health <= 0:
		get_tree().change_scene_to_file("res://resources/scenes/UI/death_screen.tscn")
	else:
		if player.health <= 25:
			play_heart_beat(true)
		else:
			if player.health <= 50:
				play_heart_beat(false)

func _on_timer_timeout() -> void:
	if player.Stamina != 100:
		stamina_update(5)
		timer.start(staminaCooldown)


func play_heart_beat(low : bool) -> void:
	if low:
		heart_beat_player.stream = HEART_BEAT_2
	else:
		match rand_gen.randi_range(1,2):
			1:
				heart_beat_player.stream = HEART_BEAT_1
			2:
				heart_beat_player.stream = HEART_BEAT_3

	heart_beat_player.play()
