extends Node3D

@export var target : Node3D

const VENT_L_PEICE = preload("uid://2hkqmgjjablv")
const VENT_MID = preload("uid://b6o4egbccpgoc")
const VENT_THREEWAY = preload("uid://wy2f0bbvn8rm")
const VENT_TWOWAY = preload("uid://dn7mbrj1057s")

var markers : Array = []

func collect_markers():
	markers = []
	for node in get_children():
		if node is Marker3D:
			markers.insert(0,node)
	print(markers)

func generate_map():
	var vent1 = VENT_MID.instantiate()
	add_child(vent1)
	
	var vent2 = VENT_THREEWAY.instantiate()
	add_child(vent2)
	vent2.global_position = Vector3(4,0,0)
	target.collectMarkers()

func add_peice():
	pass
