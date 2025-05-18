class_name DeliveryLocation
extends HoldableSlot


func _ready():
	accepted_holdables = ["plant"]

func pay(bank: Bank, plant: Plant):
	bank.balance += plant.worth.value
	plant.queue_free()
		 
	
