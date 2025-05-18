class_name PestecideLevel
extends PlantProperty

func _init(optimum: float, value: float):
	max = 100
	self.value = value
	self.optimum = optimum


func progress(current: float) -> float:
	return -(1.0 / 50.0) * log(current + 1)
