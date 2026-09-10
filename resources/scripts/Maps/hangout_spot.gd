extends allMaps

const NATALIE_TABLE_LAY = preload("uid://durtalfd5oya5")
const NATALIE_STANDING_HEAD = preload("uid://b23adon1x64ur")
const SUSIE_SITTING = preload("uid://b7a0ahpitqqwh")
const SUSIE_SITTING_CHECK_UP = preload("uid://ct4kan7squpqa")
const SUSIE_STANDING_HEAD = preload("uid://bb205q1uf0tjl")

@onready var natalie: TextureRect = $CanvasLayer/Cutscenes/Natalie
@onready var susie: TextureRect = $CanvasLayer/Cutscenes/Susie
@onready var cutscene_animation_player: AnimationPlayer = $CanvasLayer/Cutscenes/CutscneeAnimationPlayer

func _ready() -> void:
	setUpMap()
	GlobalSignalBus.emit_signal("changeMusic", "ANOTHER_KID")
