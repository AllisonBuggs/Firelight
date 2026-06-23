extends Area2D
class_name Event

var target
var state 
var stillInside
var triggered = false

@warning_ignore("unused_parameter")
func _on_area_entered(area: Area2D) -> void:
	stillInside = true
	if triggered == false:
			triggered = true

@warning_ignore("unused_parameter")
func _on_area_exited(area: Area2D) -> void:
	stillInside = false
