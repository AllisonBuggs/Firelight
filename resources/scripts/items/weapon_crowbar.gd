extends weaponItem

func _ready()->void:
	damage = 5
	primary = "genericSwipe"
	secondary = "genericSwipe"
	name = "Crowbar"
	description = "A rusty crowbar, bash and pry" 
	icon = load("res://resources/sprites/icons/Items/Crowbar.png")
