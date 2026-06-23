extends Camera2D

@onready var screenFadeAnimmationPlayer = $Sprite2D/AnimationPlayer
@onready var audioPlayer = $AudioStreamPlayer2D
@onready var noise = FastNoiseLite.new()

var tween:Tween

const LERP_WEIGHT = 0.1
const SHAKE = 0.5
const DECAY = 0.8
const MAX_OFFSET = Vector2(160, 90)
const MAX_ROLL = 0.15
const TRAUMA_POWER = 2

var trauma = 0.0
var aim_rot = 0
var base_rotation = 0
var noise_y = 0

@export var target : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignalBus.connect("activateCameraTransition", CameraTransition)
	GlobalSignalBus.connect("changeCameraSettings", changeCameraSettings)
	randomize()
	noise.seed = randi()
	noise.frequency = 0.25

func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - DECAY * delta, 0)
		shake()
	else:
		rotation = base_rotation
	global_position = target.global_position


func add_trauma(amount = SHAKE):
	trauma = amount

func shake():	
	var amount = pow(trauma, TRAUMA_POWER)
	rotation = base_rotation + MAX_ROLL * amount * noise.get_noise_1d(noise_y)
	offset[0] = MAX_OFFSET[0] * amount * noise.get_noise_1d(noise_y)
	offset[1] = MAX_OFFSET[1] * amount * noise.get_noise_1d(noise_y + 9999)
	noise_y += 1

func CameraTransition():
	screenFadeAnimmationPlayer.play("fade")
	audioPlayer.play()

@warning_ignore("unused_parameter")
func changeCameraSettings(LeftLimit,TopLimit, RightLimit,BottomLimit):
	limit_left = LeftLimit
	limit_top = LeftLimit
	limit_right = RightLimit
	limit_bottom = BottomLimit
