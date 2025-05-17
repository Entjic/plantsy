extends Node

class_name Bank

var balance = 0

func give(amount: float):
	if amount < 0:
		return
	balance += amount

func pay(amount: float):
	if amount > 0 && balance >= amount:
		balance -= amount
