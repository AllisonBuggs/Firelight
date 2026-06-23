extends Character
class_name NPC

var flip = false

@onready var spriteUpdateTimer = $spriteUpdateTimer
@onready var timer = $Timer
@export var trackingUpdateTime = 1
@export var npcIdentifier : String


func _ready():
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	navigation_agent.debug_enabled = true
	match npcIdentifier:
		"cai": 
			IdleAni = "Cai_Idle"
			WalkUpAni = ""
			WalkDownAni = ""
			WalkLeftAni = ""
			WalkRightAni = ""
			
		"issac":
			IdleAni = "Issac_WalkDown"
			WalkUpAni = "Issac_WalkUp"
			WalkDownAni = "Issac_WalkDown"
			WalkLeftAni = "Issac_WalkLeft"
			WalkRightAni = "Issac_WalkRight"
			StrafeUpAni = "Issac_StrafeUp"

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

func _on_navigation_agent_2d_navigation_finished() -> void:
	updateSpriteorAnimation()

func _on_sprite_update_timer_timeout() -> void:
	updateSpriteorAnimation()

func updateSpriteorAnimation():
	if animationOverride == false:
		if navigation_agent.is_navigation_finished():
				animationToPlay = "IDLE"
		else:
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
			visualSprite.stop()
		"WALK_UP":
			visualSprite.play(WalkUpAni)
		"WALK_LEFT":
				visualSprite.play(WalkLeftAni)
		"WALK_RIGHT":
				visualSprite.play(WalkRightAni)
		"WALK_DOWN":
				visualSprite.play(WalkDownAni)
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
	visualSprite.animation = animationName
	visualSprite.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	animationOverride = false
