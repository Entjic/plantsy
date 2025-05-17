extends Node2D
class_name ItemLocation

var accepted_types := []  # e.g., ["plant"]

func can_accept(item: Holdable) -> bool:
	return item.item_type in accepted_types
