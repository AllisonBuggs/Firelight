extends Area2D

@export var dialogFile : DialogueResource
@export var dialogStart : String= "start" 
@export var activeOnStepOn : bool = false
@export var triggerOnce : bool = true
@export var smallText : bool = false

func _ready() -> void:
	if activeOnStepOn == true:
		collision_layer = 1
		collision_mask = 1

func changeExpression(expressionName):
	DialogueManager.emit_signal("changePortrait", expressionName)

func action():
	DialogueManager.show_dialogue_balloon_scene("res://resources/scenes/UI/balloon.tscn",dialogFile, dialogStart)
	GlobalSignalBus.spawnDoorTag = null
	if triggerOnce == true:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalSignalBus.spawnDoorTag = null
		if smallText == true:
			DialogueManager.show_dialogue_balloon_scene("res://resources/scenes/UI/Cutscene_Baloon.tscn", dialogFile, "start")
		else: 
			DialogueManager.show_dialogue_balloon_scene("res://resources/scenes/UI/balloon.tscn", dialogFile, dialogStart)
		if triggerOnce == true:
			queue_free()
