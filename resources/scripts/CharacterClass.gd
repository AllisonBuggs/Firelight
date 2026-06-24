extends CharacterBody2D
class_name Character

static var instance: Character = null

@onready var attackRaycast = $AttackRayCast
@onready var visualSprite = $AnimatedSprite2D
@onready var spriteAnimationPlayer = $spriteAnimationPlayer
@onready var audioStreamPlayer = $AudioStreamPlayer2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player = Character.instance

@export var recoveryTime = 0.4
@export var maxHealth = 100
@export var health = 100
@export var movementSpeed = 80
@export var Damage : int
@export var maxStamina = 100
@export var Stamina = 100



var direction : Vector2
var orientationNumber : int
var attacks : Array[Callable]
var movementTask = "IDLE"
var animationToPlay : String
var inCombat = false
var AttackAni = null
var animationOverride = false

var Goal
var movementDirection

#AnimationVariables
var IdleAni
var WalkUpAni
var WalkDownAni
var WalkLeftAni
var WalkRightAni
var StrafeUpAni
var StrafeDownAni
var StrafeLeftAni
var StrafeRightAni
var UnarmedAttack

func setupAttackRaycast():
	GlobalSignalBus.emit_signal("attackRaycastInitiate", Damage)

func quantizeDirection(vectorToQuantize):
	orientationNumber = int(8.0 * (vectorToQuantize.rotated(PI/8.0).angle() + PI) / TAU)

func detectDirection():
	quantizeDirection(direction)

func pushCharacter(monitor: String, flip : bool):
	var force
	if monitor == "Mouse":
		var mpos = get_local_mouse_position()
		direction = mpos.normalized()
		force = 800
	#else it is movement direction
	if monitor == "Directional":
		var dpos = get_position_delta()
		direction = dpos.normalized()
		force = 2000
	if monitor == "AttackAngle":
		var rPos = attackRaycast.target_position
		direction = rPos.normalized()
		force = 2000

	detectDirection()
	match orientationNumber:
			0:
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			1:
				velocity -= Vector2(0, force)
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			2:
				velocity -= Vector2(0, force)
				move_and_slide()
			3:
				velocity -= Vector2(0, force)
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			4:
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			5:
				velocity += Vector2(0, force)
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			6:
				velocity += Vector2(0, force)
				move_and_slide()
			7:
				velocity += Vector2(0, force)
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
