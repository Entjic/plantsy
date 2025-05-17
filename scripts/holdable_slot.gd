class_name HoldableSlot
extends Node2D

@export var accepted_holdables: Array[String] = []
var held: Holdable = null

func can_accept(holdable: Holdable, facing_direction: Vector2, player: Node) -> bool:
	print("checkin if " + holdable.item_type + " is in " + str(accepted_holdables))
	if held:
		print(held.name)
		return false
	# Check if item is valid
	if holdable.item_type not in accepted_holdables:
		return false

	# Direction from player to this node (self)
	var to_self := (self.global_position - (player as CharacterBody2D).global_position).normalized()
	var facing := facing_direction.normalized()

	# Compare directions with dot product
	var alignment := facing.dot(to_self)

	# Tolerance: 0.7 ~ within ~45 degrees of facing
	if alignment < 0.7:
		print("Player is not facing me — alignment: ", alignment)
		return false

	return true

func center(holdable: Holdable) -> void:
	holdable.global_position = global_position
