extends Node
class_name Util

static func round_with_decimals(a: float, n: int):
	return roundf(a * pow(10, n)) / pow(10, n)

static func format_time(time_left: float) -> String:
	var total_seconds = int(round(time_left))
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60

	if minutes > 0:
		return "%dm %ds" % [minutes, seconds]
	else:
		return "%ds" % seconds
