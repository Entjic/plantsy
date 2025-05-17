extends Node

class_name Bank

var balance = 0

func give(amount: float):
	if amount < 0:
		return
	print("Recived " + str(amount))
	balance += amount

func pay(amount: float):
	if amount > 0 && balance >= amount:
		print("Paid " + str(amount))
		balance -= amount
		return true;
	else:
		print("Not enough balance :(");
		return false;
