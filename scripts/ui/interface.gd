extends Control

@onready var balance_label = $BalanceLabel

var bank: Bank

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bank:
		balance_label.text = "$" + str(bank.balance)
