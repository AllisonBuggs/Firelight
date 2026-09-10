extends NPCClass
class_name boss_class

var attacks_avilable = []
var idle_available = []
var recovery_available = []

var animations = [ani_walk_up, ani_walk_down, ani_walk_side]
var current_action : String = "NULL"
var current_phase : int = 0

var health : int
var stamina : int
var attack_dmg : int
var boss_title : String
var default_movement_speed : float = 4.0

var next_cycle_time : float = 1.0

# default animations
var ani_walk_up : String
var ani_walk_down : String
var ani_walk_side : String

@export var active : bool = true

@onready var attack_ray_cast: RayCast2D = $AttackRayCast
@onready var boss_audio_player: AudioStreamPlayer = $boss_audio_player
@onready var damage_player: AnimationPlayer = $damage_player

@onready var rand_gen = RandomNumberGenerator.new()

@onready var phase_timer: Timer = $phase_timer
@onready var tracker_timer: Timer = $tracker_timer

var glob_player_pos : Vector2

func setup():
	attack_ray_cast.setup(attack_dmg, false)
	GlobalSignalBus.connect("got_player_pos", update_player_pos)

func choose_random_action(array : Array):
	current_action = array.pick_random()
	match array:
		idle_available:
			current_phase = 0
		attacks_avilable:
			current_phase = 1
		recovery_available:
			current_phase = 2
	print(current_action)
	match current_action:
		"walk_into": 
			track_player()
		"idle_protect_self": 
			walk_to(global_position)
		"approach_swipe":
			pass
		"dash": 
			GlobalSignalBus.emit_signal("request_player_pos")
			movement_speed = 100.0
			walk_to(glob_player_pos)
		"throw_object":
			pass
		"pant":
			change_animation("jug_pant")
			boss_audio_player.stream = load("res://resources/sfx/boss/RF_pant_loop.wav")
			boss_audio_player.play()
			walk_to(global_position)
		"roar":
			pass

func track_player():
	if active:
		GlobalSignalBus.emit_signal("request_player_pos")
		walk_to(glob_player_pos)
		tracker_timer.start()

func update_player_pos(_player_pos):
	glob_player_pos = _player_pos

@warning_ignore("unused_parameter")
func hurt(_damage, player_vel : Vector2):
	GlobalSignalBus.emit_signal("hit_connected")
	var temp = health
	health -= _damage
	GlobalSignalBus.emit_signal("update_boss_health_bar", health, temp)
	if health <= 0:
		queue_free()
	damage_player.play("hit")
	await damage_player.animation_finished
	damage_player.play_backwards("hit")

func end_action_behaviors():
	match current_action:
		"pant":
			boss_audio_player.stream = load("res://resources/sfx/boss/RF_pant_end.wav")
			boss_audio_player.play()

func cycle_phase():
	if active:
		movement_speed = default_movement_speed
		end_action_behaviors()
		tracker_timer.stop()
		# End Action Behaviors
		match current_phase:
			0: # Idle
				choose_random_action(attacks_avilable)
				next_cycle_time = 5
			1: # Attack
				choose_random_action(recovery_available)
				next_cycle_time = 5
			2: # Recovery
				choose_random_action(idle_available)
				next_cycle_time = 3
		phase_timer.start(next_cycle_time)
	
func deal_contact_dmg(body: Node2D) -> void:
	if body is not boss_class:
		if body.has_method("hurt"):
			var knock_dir = (body.global_position - global_position).normalized()
			body.hurt(attack_dmg, knock_dir)
