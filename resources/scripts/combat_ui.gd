extends Control

@export var staminaCooldown = 0.5
@onready var hp_display: Label = $HealthDisplaySprite/HP_Display
@onready var timer = $Timer
@onready var StaminaBar = $ProgressBar
@onready var AnimationPlayerTree = $AnimationTree

var player = SaveLoad.SaveFileData
var isInCombat : bool = false

func _ready() -> void:
	GlobalSignalBus.connect("playerEnteredCombat", toggleState)
	GlobalSignalBus.connect("updatePlayerStats", statsChanged)
	StaminaBar.hide()
	hp_display.hide()

@warning_ignore("unused_parameter")
func toggleState(target: String, state: String):
	isInCombat = !isInCombat
	print("ion combat = " + str(isInCombat))
	if isInCombat == true:
		StaminaBar.show()
		hp_display.show()
		AnimationPlayerTree.active = true
		AnimationPlayerTree.set("parameters/conditions/inCombat", true)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", false)
		timer.start(staminaCooldown)
	else: 
		AnimationPlayerTree.set("parameters/conditions/inCombat", false)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", true)

func statsChanged(_Health: int, _Stamina: int):
	player.health += _Health
	hp_display.text = str(player.health)
	if player.Stamina > 0:
		player.Stamina += _Stamina
		StaminaBar.value = player.Stamina
	else: 
		player.Stamina = 1 
	if player.health <= 0:
		get_tree().change_scene_to_file("res://resources/scenes/UI/death_screen.tscn")
		
func _on_timer_timeout() -> void:
	if player.Stamina != 100:
		statsChanged(0, 5)
		timer.start(staminaCooldown)
