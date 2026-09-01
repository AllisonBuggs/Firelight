extends Sprite2D

@export var damage : int = 1
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

var captured_body : Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	captured_body = body
	if captured_body != null:
		if captured_body.has_method("hurt"):
			captured_body.hurt(damage, Vector2(0,0))

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	captured_body = null
