extends Panel

@onready var dialogSoundStream = $AudioStreamPlayer
@onready var faceImage = $TextureRect
@onready var labelNameLabel = $Panel/MarginContainer/Label
var textDialog
var canMove
var characterName
var textSpeed = 18
var face
var playDialogSound
@onready var label = $MarginContainer/dialogtext
var interactFunctionality = "none"
var floatVisibile : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	GlobalSignalBus.connect("interactableData", get_InteractableData)
	GlobalSignalBus.connect("container_data", recived_container_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_InteractableData(dialogText: String, facePath: String, nameBox: String):
	textDialog = dialogText
	interactFunctionality = "open"
	face = facePath
	characterName = nameBox
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept") :
		match interactFunctionality:
			"close":
				canMove = true
				floatVisibile = 0
				label.visible_characters = 0
				dialogSoundStream.stop()
				GlobalSignalBus.emit_signal("playerMovement", canMove)
				interactFunctionality = "none"
				hide()
				faceImage.show()
			"next":
				dialogSoundStream.stop()
			"none":
				playDialogSound = false
			"open":
				if face == "none":
					faceImage.hide()
					dialogSoundStream.stream = load("res://resources/sfx/snd_text.wav")
				else:
					faceImage.texture = load(face)
					dialogSoundStream.stream = load("res://resources/sfx/snd_txttest.wav")
				floatVisibile = 0
				playDialogSound = true
				canMove = false
				GlobalSignalBus.emit_signal("playerMovement", canMove)
				label.text = textDialog
				labelNameLabel.text = characterName
				show()
				textDialog = ""
				interactFunctionality = "close"
 
func _process(delta: float) -> void:
	if visible == true:
		if label.visible_characters < label.get_total_character_count():
			floatVisibile += textSpeed * delta
			label.visible_characters = floatVisibile

func recived_container_data():
	pass
