class_name PlantAge
extends PlantProperty

func _init():
	value = 0
	max = 24


func progress(current: float) -> float:
	return 0.2 * randf()
