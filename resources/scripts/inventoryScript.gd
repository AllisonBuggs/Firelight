extends Control

@onready var ReturnButton = $bottomPanel/HBoxContainer/returnButton
@onready var InvSlot0 = $holdingPanel/MarginContainer/HBoxContainer/AspectRatioContainer2/InvSlot0
@onready var InvSlot1 = $holdingPanel/MarginContainer/HBoxContainer/AspectRatioContainer3/InvSlot1
@onready var InvSlot2 = $holdingPanel/MarginContainer/HBoxContainer/AspectRatioContainer4/InvSlot2
@onready var InvSlot3 = $holdingPanel/MarginContainer/HBoxContainer/AspectRatioContainer5/InvSlot3
@onready var weaponSlot = $"stats&equipedPanel/MarginContainer/HBoxContainer/AspectRatioContainer/weaponSlot"
@onready var armorSlot = $"stats&equipedPanel/MarginContainer/HBoxContainer/AspectRatioContainer2/armorSlot"
@onready var popUp = $ToolTIp

@onready var inventoryAudioPlayer = $AudiinventoryAudioPlayeroStreamPlayer

@onready var tooltipDescriptionLabel = $ToolTIp/Control/MarginContainer/VBoxContainer/Label

var tooltipLabelText = ""
var item
var itemSelected

func _ready() -> void:
	GlobalSignalBus.connect("removeItem", removeItem)
	GlobalSignalBus.connect("inventoryOpened", recived_inventoryOpened)
	GlobalSignalBus.connect("container_data", recived_container_data)
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	popUp.position = get_global_mouse_position()

func _on_return_button_pressed() -> void:
	GlobalSignalBus.emit_signal("iventoryReturnButtonPressed")

func recived_inventoryOpened():
	ReturnButton.grab_focus()
	updateInventory()

func recived_container_data(contains):
	if Player.instance.inventoryContents.size() < 5:
		Player.instance.inventoryContents.insert(0, contains)
		print("ITEM ADDED ", Player.instance.inventoryContents)
	else:
		print("Not enough room")

func _on_inv_slot_0_mouse_entered() -> void:
	updateTooltip(0)
	popUp.show()

func _on_inv_slot_1_mouse_entered() -> void:
	updateTooltip(1)
	popUp.show()

func _on_inv_slot_2_mouse_entered() -> void:
	updateTooltip(2)
	popUp.show()

func _on_inv_slot_3_mouse_entered() -> void:
	updateTooltip(3)
	popUp.show()

func _on_armor_slot_mouse_entered() -> void:
	updateTooltip(0)
	popUp.show()

func _on_weapon_slot_mouse_entered() -> void:
	updateTooltip(0)
	popUp.show()

func _on_weapon_slot_mouse_exited() -> void:
	popUp.hide()

func _on_armor_slot_mouse_exited() -> void:
	popUp.hide()

func _on_inv_slot_0_mouse_exited() -> void:
	popUp.hide()

func _on_inv_slot_1_mouse_exited() -> void:
	popUp.hide()

func _on_inv_slot_2_mouse_exited() -> void:
	popUp.hide()

func _on_inv_slot_3_mouse_exited() -> void:
	popUp.hide()

func updateTooltip(slotNumber):
	if slotNumber < 0:
		tooltipDescriptionLabel.text = "Nothing"
	elif slotNumber >= Player.instance.inventoryContents.size():
		tooltipDescriptionLabel.text = "Nothing"
	else:
		match Player.instance.inventoryContents[slotNumber]:
				"Mixture":
					tooltipLabelText = "A bubbling mess in a flask."
				"Crowbar":
					tooltipLabelText = "A rusted crowbar, used to bash and pry."
				"None": 
					tooltipLabelText = "Nothing"
				"GaurdKey1": 
					tooltipLabelText = "Its a little red key, it feels important."
				"GaurdKey2": 
					tooltipLabelText = "It's a little purple key, it feels important."
				"FleshBurningMixture":
					tooltipLabelText = "Make it hurt for getting in your way, burn it away."
		tooltipDescriptionLabel.text = tooltipLabelText

func _on_inv_slot_0_pressed() -> void:
	InvSlot0.grab_focus()
	itemSelected = Player.instance.inventoryContents[0]

func _on_inv_slot_1_pressed() -> void:
	InvSlot1.grab_focus()
	itemSelected = Player.instance.inventoryContents[1]

func _on_inv_slot_2_pressed() -> void:
	InvSlot2.grab_focus()
	itemSelected = Player.instance.inventoryContents[2]

func _on_inv_slot_3_pressed() -> void:
	InvSlot3.grab_focus()
	itemSelected = Player.instance.inventoryContents[3]

func _on_armor_slot_pressed() -> void:
	armorSlot.grab_focus()

func _on_weapon_slot_pressed() -> void:
	weaponSlot.grab_focus()


func _on_drop_button_pressed() -> void:
	Player.instance.inventoryContents.remove_at(Player.instance.inventoryContents.find(itemSelected))
	inventoryAudioPlayer.stream = load("res://resources/sfx/Common/suitcase dropped to floor 3.wav")
	inventoryAudioPlayer.play()
	updateInventory()


func removeItem(itemID):
	Player.instance.inventoryContents.erase(Player.instance.inventoryContents.find(itemID))
	updateInventory()

func updateInventory():
	for i in Player.instance.inventoryContents.size():
		match Player.instance.inventoryContents[i]:
			"Mixture":
				item = "res://resources/sprites/icons/Items/useless_mixture2.png"
			"FleshBurningMixture":
				item = "res://resources/sprites/icons/Items/burning_mixture1.png"
			"Crowbar":
				item = "res://resources/sprites/icons/Items/Crowbar.png"
			"GaurdKey1":
				item = "res://resources/sprites/icons/Items/GaurdKey2.png"
			"GaurdKey2":
				item = "res://resources/sprites/icons/Items/GaurdKey1.png"
		match i:
			0:InvSlot0.icon = load(item)
			1:InvSlot1.icon = load(item)
			2:InvSlot2.icon = load(item)
			3:InvSlot3.icon = load(item)
	match Player.instance.inventoryContents.size():
		0: 
			InvSlot0.icon = load("")
			InvSlot1.icon = load("")
			InvSlot2.icon = load("")
			InvSlot3.icon = load("")
		1:
			InvSlot1.icon = load("")
			InvSlot2.icon = load("")
			InvSlot3.icon = load("")
		2:
			InvSlot2.icon = load("")
			InvSlot3.icon = load("")
		3:
			InvSlot3.icon = load("")
