@tool
extends Node2D

@onready var pupil = $Marker2D/Pupil
@onready var point = $Marker2D
@onready var audioPlayer = $AudioStreamPlayer2D
@onready var eyelid = $Eyelid
@onready var eyeball = $eyeBall
@onready var timer = $Timer

@export var variant = 1
@export var speed: float = 200  # Speed of movement


func _ready() -> void:
	match variant:
		0: ## HIDDEN EYE
			eyelid.play("blink")
			eyeball.texture = load("res://resources/sprites/icons/empty_eye.png")
			pupil.texture = load("res://resources/sprites/icons/pupil.png")
		1: ## REVEALED EYE
			eyeball.texture = load("res://resources/sprites/icons/empty_eye_inlight.png")
			pupil.texture = load("res://resources/sprites/icons/pupil_in_light.png")
			eyelid.play("default")
		2: ## EXTRAS SLEEPY EYE
			eyeball.texture = load("res://resources/sprites/Misc/extras_eye_asleep.png")
			pupil.hide()
			eyelid.hide()
		3: ## COMBAT UI EYE
			pupil.texture = load("res://resources/sprites/UI/combat_ui/boss_bar_pupil.png")
			eyeball.hide()
			eyelid.hide()

@onready var eyes = get_children()[0]
# Constants
const MAX_EYE_UP = 4

# Variables
@export var max_dist = 5

func _process(_delta) -> void:
	# Eyes following mouse
	var mouse_pos = get_local_mouse_position()
	var dir = Vector2.ZERO.direction_to(mouse_pos)
	var dist = mouse_pos.length()
	point.position = dir * min(dist, max_dist)

func _on_button_pressed() -> void:
	if audioPlayer.playing == false:
		audioPlayer.pitch_scale = randf_range(0,2)
		audioPlayer.play()


func _on_timer_timeout() -> void:
	timer.start(randi_range(2,10))
	if variant == 1:
		eyelid.play("default")
	if variant == 0:
		eyelid.play("blink")
