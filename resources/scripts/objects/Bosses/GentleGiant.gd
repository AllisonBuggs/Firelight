extends Character

var hasHitAlreadyInCollision = false
var flip = false
var currentAttackPattern : String

@onready var timer = $Timer
@onready var ProximityCheck = $ProximityCheck
@onready var coolDownTimer = $attackCooldown
@onready var spriteUpdateTimer = $spriteUpdateTimer

@export var trackingUpdateTime = 1.0
@export var attackCoolDownTime = 5.0

func _ready():
	setupAttackRaycast()
	GlobalSignalBus.connect("playerEnteredCombat", get_playerEnteredCombat)
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	navigation_agent.debug_enabled = true
	StrafeUpAni = "Issac_StrafeUp"
	StrafeDownAni = "Issac_StrafeDown"
	StrafeLeftAni = "Issac_StrafeLeft"
	StrafeRightAni = "Issac_StrafeRight"
	UnarmedAttack = "Issac_AttackUnarmed"
	movementTask = "FOLLOW"
	updateSpriteorAnimation()

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(_delta):
	match movementTask:
		"FOLLOW":
			move()
		"FREEZE":
			pass
	updateSpriteorAnimation()

func _on_timer_timeout() -> void:
	match movementTask:
		"FOLLOW":
				Goal = player.global_position
		"RETREAT":
			quantizeDirection(player.global_position)
			match orientationNumber:
					0: #LEFT
						Goal = player.global_position - Vector2(100,0)
					1:#UPLEFT
						Goal = player.global_position - Vector2(100,100)
					2: #UP
						Goal =  player.global_position - Vector2(0, 100)
					3:#UPRIGHT
						Goal = player.global_position + Vector2(100, -100)
					4:#RIGHT
						Goal = player.global_position + Vector2(0, 100)
					5:#DOWNRIGHT
						Goal = player.global_position + Vector2(100, 100)
					6:#DOWN
						Goal = player.global_position + Vector2(0, 100)
					7:#DOWNLEFT
						Goal = player.global_position + Vector2(-100, 100)
	set_movement_target(Goal)
	timer.start(trackingUpdateTime)

@warning_ignore("unused_parameter")
func get_playerEnteredCombat(target, state: String):
	Goal = player.global_position
	set_movement_target(Goal)
	timer.start(trackingUpdateTime)

func hitPlayer() -> void:
	audioStreamPlayer.play()
	GlobalSignalBus.emit_signal("updatePlayerStats", -Damage, 0)

func hurt(damageTaken : int):
	audioStreamPlayer.stream = load("res://resources/sfx/floraphonic-metal-hit-10-193281.mp3")
	audioStreamPlayer.play()
	pushCharacter("Mouse", false)
	if health != 0:
		health -= damageTaken
	else:
		die()

func _on_attack_cooldown_timeout() -> void:
	if flip == false:
		chooseAttack()
		flip = true
	else:
		attackRaycast.enabled = false
		flip = false
		coolDownTimer.start(attackCoolDownTime)

func die():
	queue_free()
	
func chooseAttack():
	var actionSelected = randi_range(0, attacks.size() - 1)
	attacks[actionSelected].call()

func grappleAttack():
	audioStreamPlayer.play()
	movementTask = "FOLLOW"
	Attack()

func attackPattern1():
	audioStreamPlayer.stream = load("res://resources/sfx/snd_txtnoe.wav")
	audioStreamPlayer.play()
	movementTask = "FOLLOW"
	Attack()

func attackPattern2():
	audioStreamPlayer.stream = load("res://resources/sfx/snd_text.wav")
	audioStreamPlayer.play()
	movementTask = "FOLLOW"
	Attack()

func retreatPattern1():
	audioStreamPlayer.stream = load("res://resources/sfx/snd_txttest.wav")
	audioStreamPlayer.play()
	movementTask = "RETREAT"
	Attack()

func attackDamage():
	attackRaycast.enabled = true
	attackRaycast.target_position = to_local(player.global_position).clamp(Vector2(-20,-20),Vector2(20,20))

func Attack():
	AttackAni = UnarmedAttack
	playAnimation(AttackAni)

func _on_navigation_agent_2d_navigation_finished() -> void:
	updateSpriteorAnimation()

func _on_sprite_update_timer_timeout() -> void:
	updateSpriteorAnimation()

func updateSpriteorAnimation():
	if animationOverride == false:
		if navigation_agent.is_navigation_finished():
				animationToPlay = "IDLE"
		else:
			if inCombat == false:
				direction = get_position_delta().normalized()
				detectDirection()
				match orientationNumber:
					0:animationToPlay = "WALK_LEFT" 
					1:animationToPlay = "WALK_UP"
					2:animationToPlay = "WALK_UP"
					3:animationToPlay = "WALK_UP"
					4:animationToPlay = "WALK_RIGHT"
					5:animationToPlay = "WALK_DOWN"
					6:animationToPlay = "WALK_DOWN"
					7:animationToPlay = "WALK_DOWN"
			if inCombat == true: 
				direction = get_position_delta().normalized()
				detectDirection()
				match orientationNumber:
					0:animationToPlay = "WALK_LEFT" 
					1:animationToPlay = "WALK_UP"
					2:animationToPlay = "WALK_UP"
					3:animationToPlay = "WALK_UP"
					4:animationToPlay = "WALK_RIGHT"
					5:animationToPlay = "WALK_DOWN"
					6:animationToPlay = "WALK_DOWN"
					7:animationToPlay = "WALK_DOWN"
	else: 
		animationToPlay = "NONE"
	match animationToPlay:
		"IDLE":
			spriteAnimationPlayer.stop()
		"WALK_UP":
			spriteAnimationPlayer.play(StrafeUpAni)
		"WALK_LEFT":
				spriteAnimationPlayer.play(StrafeLeftAni)
		"WALK_RIGHT":
				spriteAnimationPlayer.play(StrafeRightAni)
		"WALK_DOWN":
				spriteAnimationPlayer.play(StrafeDownAni)
		"NONE":
			pass

func move():
	if navigation_agent.is_navigation_finished():
		return
	navigation_agent.target_position = Goal
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movementSpeed
	move_and_slide()

func playAnimation(animationName):
	animationOverride = true
	spriteAnimationPlayer.play(animationName)

func _on_animated_sprite_2d_animation_finished() -> void:
	animationOverride = false

func _on_proximity_check_timeout() -> void:
	var distanceToPlayer = global_position.distance_to(player.global_position)
	if  distanceToPlayer < 100:
		Attack()
