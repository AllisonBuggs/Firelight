extends Character
class_name Player

func _enter_tree(): instance = self
func _exit_tree(): instance = null

var up_held = false
var down_held = false
var left_held = false
var right_held = false

@onready var collision = $actionableFinder
@onready var navAgent = $NavigationAgent2D
@onready var attackCooldownTimer = $attackCooldownTimer
@onready var rollCoolDownTimer = $rollCoolDownTimer

var movementAllowed = true
var playerState


var cooldown = false
var canMove = true
var timer_purpose
var updateRollLabel = true
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

func setupAttackRaycast():
	GlobalSignalBus.emit_signal("attackRaycastInitiate", SaveLoad.SaveFileData.Damage)

func _ready() -> void:
	GlobalSignalBus.connect("changePlayerTexture", changePlayerTexture)
	GlobalSignalBus.connect("playerEnteredCombat", enteredCombat)
	GlobalSignalBus.connect("playerMovement", playerMoveChanged) 
	GlobalSignalBus.onTriggerPlayerSpawn.connect(onSpawn)
	GlobalSignalBus.connect("playerPositionDataRequested", playerPositionDataRequested)
	
	setupAttackRaycast()


@warning_ignore("unused_parameter")
func _physics_process(delta):
	if canMove == true :
		direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
		velocity = direction * (SaveLoad.SaveFileData.movementSpeed * 60) * delta
		move_and_slide()
		if velocity != Vector2(0,0):
			detectDirection()
			match orientationNumber:
				0:
					spriteAnimationPlayer.play("fem_walk_side")
					visualSprite.flip_h = true
					playerState = "WalkLeft"
				1:
					playerState = "WalkUpLeft"
					spriteAnimationPlayer.play("fem_walk_up")
				2:
					playerState = "WalkUp"
					spriteAnimationPlayer.play("fem_walk_up")
				3:
					spriteAnimationPlayer.play("fem_walk_up")
					playerState = "WalkUpRight"
				4:
					spriteAnimationPlayer.play("fem_walk_side")
					playerState = "WalkRight"
					visualSprite.flip_h = false
				5:
					spriteAnimationPlayer.play("fem_walk_down")
					playerState = "WalkDownRight"
				6:
					spriteAnimationPlayer.play("fem_walk_down")
					playerState = "WalkDown"
				7:
					spriteAnimationPlayer.play("fem_walk_down")
					playerState = "WalkDownLeft"
		else:
			spriteAnimationPlayer.stop()
			playerState = "Idle"

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		if canMove == true:
			var actionable = collision.get_overlapping_areas()
			if actionable.size() > 0:
				print("twod")
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
				pushCharacter("Directional", false)
				GlobalSignalBus.emit_signal("updatePlayerStats", 0, -10)
				audioStreamPlayer.stream = load("res://resources/sfx/dodgeroll.wav")
				audioStreamPlayer.pitch_scale = randf_range(1,1.2)
				audioStreamPlayer.play()
				rollCoolDownTimer.start(0.5)
				updateRollLabel = true
				cooldown = true
		if event.is_action_pressed("Attack"):
			if cooldown == false && SaveLoad.SaveFileData.Stamina != 0:
				GlobalSignalBus.emit_signal("updatePlayerStats", 0, -10)
				playerState = "Attacking"
				canMove = false
				updateAttackTimer = true
				cooldown = true
				spriteAnimationPlayer.play("fem_unarmed_attack")
				attackCooldownTimer.start(recoveryTime)
				pushCharacter("Mouse", true)
				attackRaycast.enabled = true
				attackRaycast.target_position = get_local_mouse_position().clamp(Vector2(-50,-50),Vector2(50,50))

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


func _on_cool_down_timer_timeout() -> void:
	canMove = true
	attackRaycast.enabled = false
	updateRollLabel = false
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

func hurt(damageTaken):
	audioStreamPlayer.stream = load("res://resources/sfx/floraphonic-metal-hit-10-193281.mp3")
	audioStreamPlayer.play()
	GlobalSignalBus.emit_signal("updatePlayerStats",-damageTaken,0)
	
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
