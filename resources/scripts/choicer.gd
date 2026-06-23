extends Control

@onready var popUpLabel = $Panel/MarginContainer/Text
@onready var hideTimer = $Timer
@onready var popUpAnimationPlayer = $popUpAnimationPlayer

func _ready() -> void:
	GlobalSignalBus.connect("TriggerPopUp", PopUpCalled)

func PopUpCalled(text, timeOut):
	popUpLabel.text = text
	hideTimer.start(timeOut)
	popUpAnimationPlayer.play("PopUpEnter")

func _on_timer_timeout() -> void:
	popUpAnimationPlayer.play_backwards("PopUpEnter")
