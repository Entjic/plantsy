class_name shop
extends Node2D

@export var item: String;

func reciveItem() :#-> Holdable:
	print(item + "gekauft");
	#return item;



#func can_accept(holdable: Holdable) -> bool:
	#print("checkin if " + holdable.item_type + " is in " + str(accepted_holdables))
	#return holdable.item_type in accepted_holdables
#
#func center(holdable: Holdable) -> void:
	#holdable.global_position = global_position
