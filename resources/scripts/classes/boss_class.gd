extends NPCClass
class_name boss_class
@export var health : int
@export var limbs : Dictionary = {}

@export var right_leg_hp = 100
@export var left_arm_hp = 100
@export var right_arm_hp = 100
@export var torso_hp = 100

@onready var rightleg_area: Area2D = $rightleg_area
@onready var leftleg_area: Area2D = $leftleg_area
@onready var rightarm_area: Area2D = $rightarm_area
@onready var leftarm_area: Area2D = $leftarm_area
@onready var body_area: Area2D = $body_area

@onready var attack_ray_cast: RayCast2D = $AttackRayCast
var attack_dmg : int = 0

var attacks_avilable = []
var idle_available = []
var recovery_available = []

var animations = [ani_walk_up, ani_walk_down, ani_walk_side]
var current_action : String = "NULL"
var current_phase : int = 0

var stamina : int

var boss_title : String
var default_movement_speed : float = 4.0

var next_cycle_time : float = 1.0

# default animations
var ani_walk_up : String
var ani_walk_down : String
var ani_walk_side : String

@export var active : bool = true


@onready var boss_audio_player: AudioStreamPlayer2D = $boss_audio_player
@onready var damage_player: AnimationPlayer = $damage_player

@onready var rand_gen = RandomNumberGenerator.new()

@onready var phase_timer: Timer = $phase_timer
@onready var tracker_timer: Timer = $tracker_timer

var glob_player_pos : Vector2


func _ready() -> void:
	registerLimb("rightarm_area", rightarm_area)
	registerLimb("leftarm_area", leftarm_area)
	registerLimb("rightleg_area", rightleg_area)
	registerLimb("leftleg_area", leftleg_area)
	registerLimb("body_area", body_area)
	setup()
	start()

func setup():
	attack_ray_cast.setup(attack_dmg, false)
	updateHealthBar()
	GlobalSignalBus.emit_signal("set_bar_max", health)
	updateHealthBar()
	GlobalSignalBus.connect("got_player_pos", update_player_pos)


func registerLimb(limbName : String, nodeReference):
	limbs.set(limbName, nodeReference)

func removeLimb(limbName : String):
	limbs.erase(limbName)

func updateHealthBar():
	var temp = health
	health = 0
	for limb in limbs:
		if limb == "body_area":
			health += limbs[limb].limbHealth
	GlobalSignalBus.emit_signal("update_boss_health_bar", health, temp)

func deal_contact_dmg(body: Node2D) -> void:
	if body is not boss_class:
		if body.has_method("hurt"):
			var knock_dir = (body.global_position - global_position).normalized()
			body.hurt(attack_dmg, knock_dir)

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
	
