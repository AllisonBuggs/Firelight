@tool
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
var attack : int
var boss_title : String
var default_movement_speed : float = 4.0

# default animations
var ani_walk_up : String
var ani_walk_down : String
var ani_walk_side : String

@onready var rand_gen = RandomNumberGenerator.new()
@onready var phase_timer: Timer = $phase_timer

var glob_player_pos : Vector2

func setup():
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
	match current_action:
		"walk_into": 
			GlobalSignalBus.emit_signal("request_player_pos")
			walk_to(glob_player_pos)
		"idle_protect_self": 
			GlobalSignalBus.emit_signal("request_player_pos")
			walk_to(glob_player_pos)
		"approach_swipe":
			GlobalSignalBus.emit_signal("request_player_pos")
			walk_to(glob_player_pos)
		"dash": 
			GlobalSignalBus.emit_signal("request_player_pos")
			movement_speed = 60.0
			walk_to(glob_player_pos)
		"throw_object":
			GlobalSignalBus.emit_signal("request_player_pos")
			walk_to(glob_player_pos)
		"pant":
			change_animation("jug_pant")
			walk_to(global_position)
		"roar":
			walk_to(global_position)

func update_player_pos(_player_pos):
	glob_player_pos = _player_pos

func cycle_phase():
	match current_phase:
		0: # Idle
			choose_random_action(attacks_avilable)
		1: # Attack
			choose_random_action(recovery_available)
		2: # Recovery
			choose_random_action(idle_available)
	phase_timer.start()
