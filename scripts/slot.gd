class_name HoldableSlot
extends Node2D

@export var accepted_holdables: Array[String] = []

func can_accept(holdable: Holdable) -> bool:
	print("checkin if " + holdable.item_type + " is in " + str(accepted_holdables))
	return holdable.item_type in accepted_holdables

func center(holdable: Holdable) -> void:
	holdable.global_position = global_position
