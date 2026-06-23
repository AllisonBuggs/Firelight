extends AnimationPlayer

@onready var soundPlayer = $"../AudioStreamPlayer"
@onready var label = $"../MarginContainer/dialogtext"
var characterCount = 0
@onready var main = $".."
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if main.playDialogSound == true:
		if characterCount != label.visible_characters:
			characterCount = label.visible_characters
			soundPlayer.play()
