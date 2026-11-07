extends Marker3D

@export var def_marker : Marker3D
@export var marker_arrays : Array[Marker3D]

@export_category("UI Layout")
@export var LeftButton : bool = true
@export var RightButton : bool = true
@export var UpButton : bool = true
@export var DownButton : bool = true

@export_category("Next Markers")
@export var Left_Marker : Marker3D
@export var Right_Marker : Marker3D
@export var Up_Marker : Marker3D
@export var Down_Marker : Marker3D
