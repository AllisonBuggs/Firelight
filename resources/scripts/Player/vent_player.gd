extends Node3D

@onready var head: Node3D = $head
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var camera: Camera3D = $head/camera

@export var unsorted_markers : Array = []

var tween : Tween

var markers : Array[Marker3D] = []

var current_index : int = 0
var occupyingMarker : Marker3D
var focusedMarker : Marker3D
var ang : float

func collectMarkers():
	markers.clear()

	unsorted_markers = $"../vent_threeway".find_child("movement_points").get_children()
	var screen_size = camera.get_viewport().get_visible_rect().size
	var screen_center = screen_size / 2.0

	for marker in unsorted_markers:
		if camera.is_position_behind(marker.global_position):
			continue

		var screen_pos = camera.unproject_position(marker.global_position)

		if !camera.get_viewport().get_visible_rect().has_point(screen_pos):
			continue

		markers.append(marker)

	markers.sort_custom(sort_screen_distance)

	current_index = -1
	var closest_distance = INF

	for i in range(markers.size()):
		var screen_pos = camera.unproject_position(markers[i].global_position)
		var distance = screen_pos.distance_squared_to(screen_center)

		if distance < closest_distance:
			closest_distance = distance
			current_index = i

	if current_index != -1:
		focusedMarker = markers[current_index]

func cycleTarget(dir: String):
	if markers.is_empty():
		return

	var step = -1 if dir == "left" else 1
	var next_index = current_index + step

	next_index = wrapi(next_index, 0, markers.size())

	var attempts = 0

	while markers[next_index] == occupyingMarker:
		next_index = wrapi(next_index + step, 0, markers.size())
		attempts += 1

		if attempts >= markers.size():
			return

	current_index = next_index
	focusedMarker = markers[current_index]

	var dire = (focusedMarker.global_position - global_position).normalized()
	ang = atan2(dire.x, dire.z) + PI

func sort_screen_distance(a,b):
	return camera.unproject_position(a.global_position).x < camera.unproject_position(b.global_position).x

func handleTween() -> bool:
	if tween:
		if tween.is_running():
			return false
		else:
			tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN)
	return true

func _input(event: InputEvent) -> void:
	if event.is_action_released("MoveUp"):
		if handleTween():
			occupyingMarker = focusedMarker
			tween.tween_property(self, "global_position", focusedMarker.global_position, 0.5)
			audio_stream_player.play()
			await tween.finished
			tween.kill()
	if event.is_action_released("MoveLeft"):
		if handleTween():
			cycleTarget("left")
			tween.tween_property(head, "rotation:y", ang, 0.5)
			await tween.finished
			tween.kill()
			collectMarkers()
	if event.is_action_released("MoveRight"):
		if handleTween():
			cycleTarget("right")
			tween.tween_property(head, "rotation:y", ang, 0.5)
			await tween.finished
			tween.kill()
			collectMarkers()
