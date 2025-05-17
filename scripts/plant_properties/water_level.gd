class_name WaterLevel
extends PlantProperty

func _init():
	value = 25.0

func _ready() -> void:
	pass


func progress(current: float) -> float:
	return -(1.0 / 20.0) * log(current + 1)
