extends Character
class_name NPCClass

@export var movement_speed: float = 4.0
@export var movement_target : Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


var movement_delta: float
var _direction : Vector2
var direction_tolerance: float = 10.0

var animation_walk_up : String
var animation_walk_right : String
var animation_walk_left : String
var animation_walk_down : String


func start() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target():
	navigation_agent.set_target_position(movement_target)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	process_animations()
	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	move()

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
			move_and_slide()
	else:
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
	spriteAnimationPlayer.play(animation_name)

func pause_animation():
	animated_sprite_2d.pause()
	spriteAnimationPlayer.pause()

func detectDirection():
	quantizeDirection(_direction)

func quantizeDirection(vectorToQuantize):
	orientationNumber = int(8.0 * (vectorToQuantize.rotated(PI/8.0).angle() + PI) / TAU)

func process_animations():
	if navigation_agent.is_navigation_finished():
		spriteAnimationPlayer.stop()
	else:
			_direction = get_position_delta().normalized()
			detectDirection()
			match orientationNumber:
				0:spriteAnimationPlayer.play(animation_walk_left)
				1:spriteAnimationPlayer.play(animation_walk_up)
				2:spriteAnimationPlayer.play(animation_walk_up)
				3:spriteAnimationPlayer.play(animation_walk_up)
				4:spriteAnimationPlayer.play(animation_walk_right)
				5:spriteAnimationPlayer.play(animation_walk_down)
				6:spriteAnimationPlayer.play(animation_walk_down)
				7:spriteAnimationPlayer.play(animation_walk_down)
	if velocity.abs().max_axis_index() == Vector2.Axis.AXIS_X:
		if velocity.x > 0:
			spriteAnimationPlayer.play(animation_walk_right)
		else:
			if spriteAnimationPlayer.current_animation != animation_walk_left:
				spriteAnimationPlayer.play(animation_walk_left)

func walk_to(goal_position : Vector2):
	movement_target = goal_position
	set_movement_target()
