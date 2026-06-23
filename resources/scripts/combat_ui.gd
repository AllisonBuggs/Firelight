extends Control

@export var staminaCooldown = 0.5
@onready var HealthLabel = $HealthDisplay
@onready var timer = $Timer
@onready var StaminaBar = $ProgressBar
@onready var AnimationPlayerTree = $AnimationTree
var isInCombat = false

func _ready() -> void:
	GlobalSignalBus.connect("playerEnteredCombat", toggleState)
	GlobalSignalBus.connect("updatePlayerStats", statsChanged)
	StaminaBar.hide()
	HealthLabel.hide()

@warning_ignore("unused_parameter")
func toggleState(target: String, state: String):
	isInCombat = !isInCombat
	if isInCombat == true:
		StaminaBar.show()
		HealthLabel.show()
		AnimationPlayerTree.active = true
		AnimationPlayerTree.set("parameters/conditions/inCombat", true)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", false)
		timer.start(staminaCooldown)
	else: 
		AnimationPlayerTree.set("parameters/conditions/inCombat", false)
		AnimationPlayerTree.set("parameters/conditions/notInCombat", true)

func statsChanged(_Health: int, _Stamina: int):
	Character.instance.health += _Health
	HealthLabel.text = "HP:" + type_convert(Character.instance.health, 4)
	if Character.instance.Stamina > 0:
		Character.instance.Stamina += _Stamina
		StaminaBar.value = Character.instance.Stamina
	else: 
		Character.instance.Stamina = 1 
	if Character.instance.health <= 0:
		get_tree().change_scene_to_file("res://resources/scenes/UI/death_screen.tscn")
		
func _on_timer_timeout() -> void:
	if Character.instance.Stamina != 100:
		statsChanged(0, 5)
		timer.start(staminaCooldown)
