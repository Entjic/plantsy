class_name FertilizerLevel
extends PlantProperty

func _ready() -> void:
	max = 25
	value = 10


func progress(current: float) -> float:
	return -(1.0 / 100.0) * log(current + 1)
