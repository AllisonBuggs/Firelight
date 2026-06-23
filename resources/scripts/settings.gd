extends Panel

@onready var bar = $Tabs/TabBar
@onready var VideoItems = $VideoItems
@onready var GameplayItems = $GameplayItems
@onready var AudioItems = $AudioItems
@onready var AccessibilityItems = $AccessibilityItems
@onready var ControlItems = $ControlItems
@onready var returnButton = $ReturnButton

func _ready() -> void:
	GlobalSignalBus.connect("settingsOpened", recived_settingsOpened)

func recived_settingsOpened():
	returnButton.grab_focus()

func _on_tab_bar_tab_changed(tab: int) -> void:
	match tab:
		0: 
			VideoItems.show()
			GameplayItems.hide()
			AudioItems.hide()
			AccessibilityItems.hide()
			ControlItems.hide()
		1: 
			VideoItems.hide()
			GameplayItems.show()
			AudioItems.hide()
			AccessibilityItems.hide()
			ControlItems.hide()
		2: 
			VideoItems.hide()
			GameplayItems.hide()
			AudioItems.show()
			AccessibilityItems.hide()
			ControlItems.hide()
		3: 
			VideoItems.hide()
			GameplayItems.hide()
			AudioItems.hide()
			AccessibilityItems.hide()
			ControlItems.show()
		4: 
			VideoItems.hide()
			GameplayItems.hide()
			AudioItems.hide()
			AccessibilityItems.show()
			ControlItems.hide()

func _on_return_button_pressed() -> void:
	GlobalSignalBus.emit_signal("returnButtonPressed")


func vsync_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func Fullscreen_Toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func LockFrameRateOptionSelected(index: int) -> void:
	match index:
		0:Engine.max_fps = 60
		1:Engine.max_fps = 30

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_dialog_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dialog"), linear_to_db(value))


func _on_ambient_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), linear_to_db(value))
