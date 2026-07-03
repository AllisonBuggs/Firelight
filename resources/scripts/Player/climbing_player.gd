extends CharacterBody2D

const RECOVERY_TIME: float = 0.3
const JUMP_VELOCITY: float = -300.0

# Preloaded Sound Effects
const SFX_JUMP = preload("uid://btn7claay00lb")
const LANDING = preload("uid://br7glxq68nxf5")



@onready var timer_label: Label = $timer_label
@onready var trip_timer: Timer = $trip_timer
@onready var recover_timer: Timer = $recover_timer
@onready var ledge_grab_hit: RayCast2D = $ledge_grab_hit
@onready var grapple_save_timer: Timer = $grapple_save_timer
@onready var player_audio_player: AudioStreamPlayer = $player_audio_player
@onready var player_animation_player: AnimationPlayer = $player_animation_player

var SPEED : float = 50.0
var direction ## I Dont know what to put here for the assingment
var can_save : bool = false
var can_move : bool = true
var landing : bool
var falling : bool = false
var wind_velocity : Vector2 = Vector2.ZERO
var state : String

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_move:
		if is_on_floor():
			jump()

func jump():
	player_audio_player.stream = SFX_JUMP
	player_audio_player.pitch_scale = 1
	player_audio_player.play()
	player_animation_player.play("feral_jump")
	trip_timer.start()
	SPEED = 200.0
	velocity.x = direction * SPEED
	velocity.y = JUMP_VELOCITY
	move_and_slide()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	timer_label.text = str(roundf(trip_timer.time_left))
	if falling:
		state = "FALL"
	else:
		if is_on_floor():
				if !direction:
					state = "IDLE"
				else:
					state = "WALK"
		else:
			state = "AIR"

	match state:
		"WALK":
			player_animation_player.play("feral_scoot")
		"FALL":
			player_animation_player.play("PlayerFlat")
		"AIR":
			player_animation_player.play("feral_jump")
		"IDLE":
			player_animation_player.play("feral_scoot")
			player_animation_player.pause()

func _physics_process(delta: float) -> void:
	if falling:
		if ledge_grab_hit.is_colliding():
			print("New ledge")
			grapple_save_timer.start()
			if can_save:
				set_collision_layer_value(1, true)
				set_collision_mask_value(1,true)
				falling = false
				can_save = false
# Landing Code
	if is_on_floor():
		if landing:
			can_move = false
			player_audio_player.pitch_scale = 1
			player_audio_player.stream = LANDING
			player_audio_player.play()
			recover_timer.start(RECOVERY_TIME)
			landing = false
	else:
		if !landing:
			landing = true
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		SPEED = 50.0
	# Get the input direction and handle the movement/deceleration.
	# A good practice, you should replace UI actions with custom gameplay actions.
	if can_move: 
		direction = Input.get_axis("MoveLeft", "MoveRight")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x,0, 20)
		velocity.y = move_toward(velocity.y,0, 20)
	velocity += wind_velocity
	move_and_slide()

func end_wind():
	wind_velocity = Vector2.ZERO

func wind_blow(wind_direction):
	if wind_direction == 1:
		wind_velocity = Vector2(10,0)
	else:
		wind_velocity = Vector2(-10,0)

func _on_trip_timer_timeout() -> void:
	print("Tripped")
	falling = true
	player_audio_player.pitch_scale = 1
	player_audio_player.stream = SFX_JUMP
	player_audio_player.play()
	set_collision_layer_value(1, false)
	set_collision_mask_value(1,false)


func _on_recover_timer_timeout() -> void:
	can_move = true


func _on_grapple_save_timer_timeout() -> void:
	can_save = true

func footstep_play():
	player_audio_player.stream = SFX_JUMP
	player_audio_player.pitch_scale = 2.5
	player_audio_player.play()
