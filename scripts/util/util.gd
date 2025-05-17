extends Node
class_name Util

static func round_with_decimals(a: float, n: int):
	return roundf(a * pow(10, n)) / pow(10, n)
