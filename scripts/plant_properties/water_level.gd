class_name WaterLevel
extends PlantProperty

func _ready() -> void:
	value = 25.0


func progress(current: float) -> float:
	return -(1.0 / 40.0) * log(current + 1)
