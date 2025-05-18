class_name WaterLevel
extends PlantProperty

func _init(optimum: float, value: float):
	self.value = value
	self.optimum = optimum

func _ready() -> void:
	pass


func progress(current: float) -> float:
	return -(1.0 / 20.0) * log(current + 1)
