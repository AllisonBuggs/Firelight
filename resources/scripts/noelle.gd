extends Character
class_name Player

func _enter_tree(): instance = self
func _exit_tree(): instance = null

var up_held = false
var down_held = false
var left_held = false
var right_held = false

@export var recoveryTime : float = 0.4

@onready var attackRaycast = $AttackRayCast
@onready var audioStreamPlayer = $AudioStreamPlayer2D
@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D

@onready var collision = $actionableFinder
@onready var navAgent = $NavigationAgent2D


@onready var attack_cooldown_timer: Timer = $attackCooldownTimer
@onready var rollCoolDownTimer = $rollCoolDownTimer


## Sound Effects Player
@onready var sfx_swipe_player: AudioStreamPlayer = $sfx_swipe_player
@onready var sfx_hit_player: AudioStreamPlayer = $sfx_hit_player

## PRELOAD SOUNDS

const ROLL = preload("uid://ubs3xoe0jxj2")
const PUNCH = preload("uid://cg4s4oinxf20r")
const PUNCH_2 = preload("uid://bet5sg2rwkys")
const PUNCH_3 = preload("uid://bpvo2230qar10")
const SWIPE = preload("uid://bk773dg2vnfnm")


var movementAllowed = true
var playerState

var dash_vel = 2
var dash_multipler = 1

var cooldown = false
var canMove = true
var timer_purpose
var updateAttackTimer = true

const directions = [
	"Left",
	"Up left",
	"Up",
	"Up right",
	"right",
	"Down right",
	"Down",
	"Down left"
]

func _ready() -> void:
	attackRaycast.setup(10, true)
	GlobalSignalBus.connect("hit_connected", play_hit_sound)
	GlobalSignalBus.connect("do_freeze_player", playermovefalse)
	GlobalSignalBus.connect("request_player_pos", send_player_pos)
	GlobalSignalBus.connect("changePlayerTexture", changePlayerTexture)
	GlobalSignalBus.connect("playerEnteredCombat", enteredCombat)
	GlobalSignalBus.connect("playerMovement", playerMoveChanged) 
	GlobalSignalBus.connect("playerPositionDataRequested", playerPositionDataRequested)
	GlobalSignalBus.emit_signal("updatePlayerHealth",0)
	GlobalSignalBus.onTriggerPlayerSpawn.connect(onSpawn)

func move(delta : float ):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = ((direction * (SaveLoad.SaveFileData.movementSpeed * 60)) * dash_multipler) * delta

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if canMove == true :
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
			print(knockback_timer)
			if knockback_timer <= 0.0:
				knockback_timer = 0
				knockback = Vector2.ZERO
		else:
			move(delta)
		move_and_slide()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if do_velocity_animations:
		if velocity != Vector2(0,0):
			detectDirection()
			match orientationNumber:
				0:
					spriteAnimationPlayer.play("feral_walk_side")
					visualSprite.flip_h = true
					playerState = "WalkLeft"
				1:
					playerState = "WalkUpLeft"
					spriteAnimationPlayer.play("feral_walk_up")
				2:
					playerState = "WalkUp"
					spriteAnimationPlayer.play("feral_walk_up")
				3:
					spriteAnimationPlayer.play("feral_walk_up")
					playerState = "WalkUpRight"
				4:
					spriteAnimationPlayer.play("feral_walk_side")
					playerState = "WalkRight"
					visualSprite.flip_h = false
				5:
					spriteAnimationPlayer.play("feral_walk_down")
					playerState = "WalkDownRight"
				6:
					spriteAnimationPlayer.play("feral_walk_down")
					playerState = "WalkDown"
				7:
					spriteAnimationPlayer.play("feral_walk_down")
					playerState = "WalkDownLeft"
		else:
				spriteAnimationPlayer.stop()
				playerState = "Idle"

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		if canMove == true:
			var actionable = collision.get_overlapping_areas()
			if actionable.size() > 0:
				actionable[0].action()
				return
	if event.is_action_pressed("MoveUp"):
		up_held = true
	if event.is_action_pressed("MoveDown"):
		down_held = true
	if event.is_action_pressed("MoveLeft"):
		left_held = true
	if event.is_action_pressed("MoveRight"):
		right_held = true
	if event.is_action_released("MoveUp"):
		up_held = false
	if event.is_action_released("MoveDown"):
		down_held = false
	if event.is_action_released("MoveLeft"):
		left_held = false
	if event.is_action_released("MoveRight"):
		right_held = false
	if inCombat == true:
		if event.is_action_released("Roll"):
			if cooldown == false && SaveLoad.SaveFileData.Stamina != 0:
				commit_roll()
				GlobalSignalBus.emit_signal("updatePlayerStamina", -10)
				audioStreamPlayer.play()
				spriteAnimationPlayer.play("feral_pinball")
				rollCoolDownTimer.start(0.5)
				
				audioStreamPlayer.stream = ROLL
				audioStreamPlayer.pitch_scale = randf_range(1,1.2)
				
				do_velocity_animations = false
				cooldown = true
				
		if event.is_action_pressed("Attack"):
			if cooldown == false && SaveLoad.SaveFileData.Stamina != 0:
				GlobalSignalBus.emit_signal("updatePlayerStamina", -10)
				playerState = "Attacking"
				canMove = false
				updateAttackTimer = true
				cooldown = true
				spriteAnimationPlayer.play("fem_unarmed_attack")
				attack_cooldown_timer.start(recoveryTime)
				attackRaycast.enabled = true
				flip_twoards_mouse()
				sfx_swipe_player.stream = SWIPE
				sfx_swipe_player.play()
				attackRaycast.target_position = get_local_mouse_position().clamp(Vector2(-30,-30),Vector2(30,30))
				do_velocity_animations = false

func play_hit_sound():
	match randi_range(0,2):
		0:
			sfx_hit_player.stream = PUNCH
			sfx_hit_player.play()
		1:
			sfx_hit_player.stream = PUNCH_2
			sfx_hit_player.play()
		2:
			sfx_hit_player.stream = PUNCH_3
			sfx_hit_player.play()


func flip_twoards_mouse():
	var mpos = get_local_mouse_position()
	direction = mpos.normalized()
	detectDirection()
	match orientationNumber:
			0: ##RIGHT 
					visualSprite.flip_h = false
			1:##UP LEFT
					visualSprite.flip_h = false
			3: ## UP
					visualSprite.flip_h = true
			4: ##LEFT
					visualSprite.flip_h = true
			5: ## down rightw
					visualSprite.flip_h = true
			7:## DOWN LEFT
					visualSprite.flip_h = false

func playermovefalse():
	playerMoveChanged(false)

func playerMoveChanged(_canMove: bool):
	canMove = _canMove
	if !canMove:
		spriteAnimationPlayer.stop()
		playerState = "Idle"

func playerPositionDataRequested(positionToSet):
		global_position = positionToSet

func _on_timer_timeout() -> void:
	cooldown = false
	updateAttackTimer = false
	do_velocity_animations = true

func _on_cool_down_timer_timeout() -> void:
	canMove = true
	attackRaycast.enabled = false
	do_velocity_animations = true
	cooldown = false

@warning_ignore("unused_parameter")
func enteredCombat(target: String, state: String):
	if state == "None":
		inCombat = false
		SaveLoad.SaveFileData.movementSpeed = 90
	else:
		inCombat = true
		SaveLoad.SaveFileData.movementSpeed = 130

func movePlayerToDoor(Position):
	global_position = Position

@warning_ignore("unused_parameter")
func onSpawn(playerPosition):
	print("player position set to " + str(playerPosition) + " on spawn")
	global_position = playerPosition

func hurt(damageTaken: int, knock_dir : Vector2):
	set_knockback(knock_dir, 500, 0.5)
	spriteAnimationPlayer.play("feral_pinball")
	rollCoolDownTimer.start(0.5)
	do_velocity_animations = false
	audioStreamPlayer.stream = load("res://resources/sfx/Chequered Ink/punch.wav")
	audioStreamPlayer.play()
	GlobalSignalBus.emit_signal("updatePlayerHealth",-damageTaken)
	
func die():
	audioStreamPlayer.stream = load("res://resources/sfx/universfield-cartoon-fail-trumpet-278822.mp3")
	audioStreamPlayer.play()

func play_footstep():
	FootstepSoundManager.play_footstep(global_position)

func changePlayerAnimation(animationName : String):
	match animationName:
		"UpIdle": 
			spriteAnimationPlayer.play("fem_walk_up")
			spriteAnimationPlayer.stop()
			playerState = "Idle"
		"DownIdle": 
			spriteAnimationPlayer.play("fem_walk_down")
			spriteAnimationPlayer.stop()
			playerState = "Idle"
		"LeftIdle": 
			spriteAnimationPlayer.play("fem_walk_side")
			spriteAnimationPlayer.stop()
			playerState = "Idle"
			visualSprite.flip_h = true
		"RightIdle": 
			spriteAnimationPlayer.play("fem_walk_side")
			spriteAnimationPlayer.stop()
			visualSprite.flip_h = false
			playerState = "Idle"
		_: 
			spriteAnimationPlayer.play(animationName)

func changePlayerTexture(imagePath):
	visualSprite.animation = imagePath

func send_player_pos():
	GlobalSignalBus.emit_signal("got_player_pos", global_position)

func commit_roll():
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "dash_multipler", dash_vel, 0.2)
	tween.tween_property(self, "dash_multipler", 1, 0.2)

func set_veloicy_animation_() -> void:
	do_velocity_animations = true
