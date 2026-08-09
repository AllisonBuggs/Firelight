extends CharacterBody2D
class_name Character

static var instance: Character = null


@onready var visualSprite = $AnimatedSprite2D
@onready var spriteAnimationPlayer: AnimationPlayer = $spriteAnimationPlayer

var direction : Vector2
var orientationNumber : int

var animationToPlay : String

var inCombat = false
var AttackAni = null


func quantizeDirection(vectorToQuantize):
	orientationNumber = int(8.0 * (vectorToQuantize.rotated(PI/8.0).angle() + PI) / TAU)

func detectDirection():
	quantizeDirection(direction)

func apply_knockback(attacker_vel : Vector2, knockback : int):
	print(attacker_vel)
	var _direction = (attacker_vel - velocity).normalized() * knockback
	velocity = _direction
	move_and_slide()

func pushCharacter(monitor: String, flip : bool, is_knockback : bool, attackRaycast):
	var force
	if monitor == "Mouse":
		var mpos = get_local_mouse_position()
		direction = mpos.normalized()
		force = 800
	if monitor == "Directional":
		var dpos = get_position_delta()
		direction = dpos.normalized()
		print(direction)
		if !is_knockback:
			force = 2000
		else:
			force = -2000
	if monitor == "AttackAngle":
		var rPos = attackRaycast.target_position
		direction = rPos.normalized()
		force = 2000
	detectDirection()
	match orientationNumber:
			0: ##RIGHT 
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			1:##UP LEFT
				velocity -= Vector2(0, force)
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			2:## UP RIGHT
				velocity -= Vector2(0, force)
				move_and_slide()
			3: ## UP
				velocity -= Vector2(0, force)
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			4: ##LEFT
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			5: ## down rightw
				velocity += Vector2(0, force)
				velocity += Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			6: ## DOWN
				velocity += Vector2(0, force)
				move_and_slide()
			7:## DOWN LEFT
				velocity += Vector2(0, force)
				velocity -= Vector2(force, 0)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
	print(orientationNumber)
