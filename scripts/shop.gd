class_name shop
extends Node2D

@export var itemType: String;
#@export var item: Holdable;
@export var item: PackedScene;
@export var price: float;

#func reciveItem() :#-> Holdable:
	#print(itemType + " gekauft");
	##return item;

func reciveItem() -> Holdable:
	print(itemType + " gekauft")
	if item:
		
		var new_item = item.instantiate() as Holdable
		
		#get_tree().current_scene.add_child(new_item)

		# Setze Position (hier einfach Beispielposition – besser: Spielerposition)
		#new_item.position = self.position #+ Vector2(32, 0)

		return new_item
		
	else:
		print("Fehler: Kein Item definiert")
		return null


#func can_accept(holdable: Holdable) -> bool:
	#print("checkin if " + holdable.item_type + " is in " + str(accepted_holdables))
	#return holdable.item_type in accepted_holdables
#
#func center(holdable: Holdable) -> void:
	#holdable.global_position = global_position
