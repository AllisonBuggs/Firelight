extends TextureRect

@export var puppet_file : Puppet

var tween : Tween

func change_expression(expression : String):
	texture = puppet_file.expressions[expression]

func move(final_pos : Vector2):
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", final_pos, 1)
	await tween.finished
	tween.kill()
