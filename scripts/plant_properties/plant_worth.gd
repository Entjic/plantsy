class_name PlantWorth
extends PlantProperty

var health: PlantHealth

func _init(health: PlantHealth):
	self.health = health
	value = 10.0


func progress(current: float) -> float:
	if health.value < 33.0:
		return -value
	elif health.value < 66.0:
		return -0.05
	else:
		return 0
