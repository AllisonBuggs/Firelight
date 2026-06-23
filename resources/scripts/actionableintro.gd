extends Area2D

@export var dialogFile : DialogueResource
@export var dialogStart : String= "start" 

func changeExpression(expressionName):
	DialogueManager.emit_signal("changePortrait", expressionName)


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	DialogueManager.show_dialogue_balloon_scene("res://addons/dialogue_manager/example_balloon/IntroBalloon.tscn", dialogFile, dialogStart)
