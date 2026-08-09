extends Sprite2D

@export var damage : int = 10

var captured_body : Node2D

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if captured_body != null:
		captured_body.hurt(damage)

func _on_area_2d_body_entered(body: Node2D) -> void:
	captured_body = body


@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	captured_body = null
