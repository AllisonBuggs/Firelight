extends CharacterBody2D
class_name Character

static var instance: Character = null


@onready var visualSprite = $AnimatedSprite2D
@onready var spriteAnimationPlayer: AnimationPlayer = $spriteAnimationPlayer

var direction : Vector2
var orientationNumber : int

var animationToPlay : String

var inCombat = false

var do_velocity_animations = true

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0.0

func quantizeDirection(vectorToQuantize):
	orientationNumber = int(8.0 * (vectorToQuantize.rotated(PI/8.0).angle() + PI) / TAU)

func detectDirection():
	quantizeDirection(direction)

func set_knockback(dir : Vector2, Force : float, dur : float):
	knockback = dir * Force
	knockback_timer = dur

func pushCharacter(monitor: String, flip : bool, is_knockback : bool, attackRaycast):
	var force : int
	var tween : Tween = create_tween()
	var time : float = 0.2
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)

	if monitor == "Mouse":
		var mpos = get_local_mouse_position()
		direction = mpos.normalized()
		force = 800
	if monitor == "Directional":
		var dpos = get_position_delta()
		direction = dpos.normalized()
		if !is_knockback:
			force = 100
		else:
			force = -2000
	if monitor == "AttackAngle":
		var rPos = attackRaycast.target_position
		direction = rPos.normalized()
		force = 2000

	detectDirection()
	match orientationNumber:
			0: ##LEFT 
				tween.tween_property(self, "position", 
				position + Vector2(-force,0), time)
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			1:##UP LEFT
				tween.tween_property(self, "position", 
				position + Vector2(-force,-force), time)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
			2:## UP 
				tween.tween_property(self, "position", 
				position + Vector2(0,-force), time)
				move_and_slide()
			3: ## UPRIGHT
				tween.tween_property(self, "position", 
				position + Vector2(force,-force), time)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			4: ##RIGHT
				tween.tween_property(self, "position", 
				position + Vector2(force,0), time)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			5: ## down right
				tween.tween_property(self, "position", 
				position + Vector2(force,force), time)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = true
			6: ## DOWN
				tween.tween_property(self, "position", 
				position + Vector2(0,force), time)
				move_and_slide()
			7:## DOWN LEFT
				tween.tween_property(self, "position", 
				position + Vector2(-force,force), time)
				move_and_slide()
				if monitor == "Mouse" and flip == true:
					visualSprite.flip_h = false
