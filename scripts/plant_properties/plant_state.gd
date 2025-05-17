class_name PlantState
extends PlantProperty

var properties: Array[PlantProperty] = []

func _init(properties: Array[PlantProperty]):
	self.properties = properties

func _ready() -> void:
	value = calculate_state()


func progress(current: float) -> float:
	value = 0
	return calculate_state()
	
func calculate_state():
	var state = 100.0
	for p in self.properties:
		state -= abs(p.optimum - p.value)
	return state
