extends Area2D

@export var dialogFile : DialogueResource
@export var dialogStart : String= "start" 
@export var activeOnStepOn : bool = false
@export var triggerOnce : bool = true
@export var smallText : bool = false

const BALLOON = preload("uid://cn1dkki7x6vy3")
const CUTSCENE_BALLOON = preload("uid://cy757to5k3igj")

var triggered : bool = false

func _ready() -> void:
	if activeOnStepOn == true:
		collision_layer = 1
		collision_mask = 1

func changeExpression(expressionName):
	DialogueManager.emit_signal("changePortrait", expressionName)

func action():
	DialogueManager.show_dialogue_balloon_scene(BALLOON,dialogFile, dialogStart)
	GlobalSignalBus.spawnDoorTag = null
	if triggerOnce == true:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !triggered:
			triggered = true
			print("triggered on enter")
			GlobalSignalBus.spawnDoorTag = null
			if smallText == true:
				DialogueManager.show_dialogue_balloon_scene(CUTSCENE_BALLOON, dialogFile, dialogStart)
			else: 
				DialogueManager.show_dialogue_balloon_scene(BALLOON, dialogFile, dialogStart)
			if triggerOnce == true:
				queue_free()
