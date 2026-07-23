@tool
extends CharacterBody2D
class_name NPCClass

@export var movement_speed: float = 4.0
@export var movement_target : Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var movement_delta: float
var _direction : Vector2
var direction_tolerance: float = 10.0
var orientationNumber : int

var animation_walk_up : String
var animation_walk_right : String
var animation_walk_left : String
var animation_walk_down : String

var do_velocity_animations = true

func start() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target():
	navigation_agent.set_target_position(movement_target)


func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		animation_player.stop()
	else:
			_direction = get_position_delta().normalized()
			detectDirection()
			match orientationNumber:
				0:animation_player.play(animation_walk_left)
				1:animation_player.play(animation_walk_up)
				2:animation_player.play(animation_walk_up)
				3:animation_player.play(animation_walk_up)
				4:animation_player.play(animation_walk_right)
				5:animation_player.play(animation_walk_down)
				6:animation_player.play(animation_walk_down)
				7:animation_player.play(animation_walk_down)
			print(orientationNumber)
	if velocity.abs().max_axis_index() == Vector2.Axis.AXIS_X:
		if velocity.x > 0:
			animation_player.play(animation_walk_right)
		else:
			if animation_player.current_animation != animation_walk_left:
				animation_player.play(animation_walk_left)

	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	move()

func move():
	if navigation_agent.is_navigation_finished():
		return
	navigation_agent.target_position = movement_target
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	move_and_slide()
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

func change_animation(animation_name: String):
	animation_player.play(animation_name)

func pause_animation():
	animated_sprite_2d.pause()
	animation_player.pause()

func detectDirection():
	quantizeDirection(_direction)

func quantizeDirection(vectorToQuantize):
	orientationNumber = int(8.0 * (vectorToQuantize.rotated(PI/8.0).angle() + PI) / TAU)
