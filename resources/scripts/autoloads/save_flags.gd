extends Resource
class_name SaveDataResource

@export var playerName = "Susie"
@export var completionPercent = 0
@export var timeElapsed = 0
@export var firstTime = true
@export var maxHealth = 100
@export var health = 100
@export var movementSpeed = 80
@export var Damage : int
@export var maxStamina = 100
@export var Stamina = 100
@export var armor = "None"
@export var equipped = "None"

@export var inventoryContents = ["FleshBurningMixture", "GaurdKey1", "GaurdKey2"]
@export var current_map = ""
@export var player_position = Vector2(0,0)

@export var burned_away_flesh = false
@export var barricaded_lab_door = true
@export var barricaded_exp2_door = true
@export var barricaded_maintence_door = true
@export var twolegs_dead = false
@export var halfface_dead = false
@export var hasGaurd1Seen = false
@export var Key1In = true
@export var Key2In = true
@export var LockdownTriggered = true
