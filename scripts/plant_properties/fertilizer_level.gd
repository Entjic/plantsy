class_name FertilizerLevel
extends PlantProperty

func _init():
	max = 25
	value = 10
	optimum = 20


func progress(current: float) -> float:
	return -(1.0 / 50.0) * log(current + 1)
