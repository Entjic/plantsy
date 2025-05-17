class_name shop
extends Node2D

@export var itemType: String;
@export var item: PackedScene;
@export var price: float;

func reciveItem() -> Holdable:
	print(itemType + " gekauft")
	if item:
		var new_item = item.instantiate() as Holdable
		new_item.type = itemType
		new_item.setTextures()
		return new_item
	else:
		print("Fehler: Kein Item definiert")
		return null
