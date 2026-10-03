extends HBoxContainer

@onready var label: Label = $Label
@onready var line_edit: LineEdit = $LineEdit

@export var prop_name : String
@export var prop_value : Variant

func value_changed():
	SaveLoad.SaveFileData.set(prop_name, line_edit.text)

@warning_ignore("unused_parameter")
func _on_line_edit_text_submitted(new_text: String) -> void:
	value_changed()
