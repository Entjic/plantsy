extends Node

class_name Bank

var balance = 0
var tree

func _init(_tree: SceneTree) -> void:
	balance = 10
	tree = _tree

func give(amount: float):
	if amount < 0:
		tree.get_root().get_node("Main").message_queue.show_message("Received " + str(amount))
		return
	tree.get_root().get_node("Main").message_queue.show_message("Recived " + str(amount))
	balance += amount

func pay(amount: float):
	if amount > 0 && balance >= amount:
		tree.get_root().get_node("Main").message_queue.show_message("Paid " + str(amount))
		balance -= amount
		return true;
	else:
		tree.get_root().get_node("Main").message_queue.show_message(str(amount-balance) + " balance missing" )
		return false;
