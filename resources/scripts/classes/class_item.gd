# item.gd
class_name Item
extends Resource

@export var id: String
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var max_stack: int = 1
@export var item_type: ItemType

enum ItemType { WEAPON, ARMOR, CONSUMABLE, MATERIAL, KEY_ITEM }
