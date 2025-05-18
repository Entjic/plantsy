extends Control

@onready var balance_label = $BalanceLabel

var bank: Bank

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if bank:
		balance_label.text = "$" + str(Util.round_with_decimals(bank.balance, 2))
