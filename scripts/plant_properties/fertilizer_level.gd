class_name FertilizerLevel
extends PlantProperty

func _init():
	max = 100
	value = 20
	optimum = 40


func progress(current: float) -> float:
	return -(1.0 / 50.0) * log(current + 1)
