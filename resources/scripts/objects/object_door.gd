@tool
extends Area2D

@export var flipped : bool = false
@export var openSprite : Texture
@export var closedSprite : Texture
@export var closeDoorSFX : AudioStream
@export var openDoorSFX : AudioStream
@export var try_door_sfx : AudioStream
@export var locked : bool
@export var TopDown : bool
@export var lightOnlyMaterial = false


@onready var audioPlayer = $AudioStreamPlayer2D
@onready var doorSprite = $Node2D/Node2D
@onready var collision = $Node2D/OpenDoor

var open = false

func _ready() -> void:
	updateDoorState()
	if flipped == true:
		$Node2D/Node2D.flip_h = true
	else:
		$Node2D/Node2D.flip_h = false
	if lightOnlyMaterial:
		doorSprite.material = load("res://resources/shaders/shadowafect.tres")

func action() -> void:
	if !locked:
		open = !open
		updateDoorState()
	if !audioPlayer.playing:
		playSound()

func playSound():
	if locked == false:
		if open == true:
			audioPlayer.stream = openDoorSFX
			audioPlayer.play()
		else:
			audioPlayer.stream = closeDoorSFX
			audioPlayer.play()
	else:
			audioPlayer.stream = try_door_sfx
			audioPlayer.play()

func updateDoorState():
	if open == true:
		doorSprite.texture = openSprite
		collision.disabled = true
	else:
		doorSprite.texture = closedSprite
		collision.disabled = false
		
func _on_resource_set():
	doorSprite.texture = closedSprite

func update():
	if locked:
		doorSprite.texture = closedSprite
		collision.disabled = false
