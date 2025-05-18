class_name PlantHealth
extends PlantProperty

var state: PlantState

func _init(state: PlantState):
	self.state = state
	value = 100.0


func progress(current: float) -> float:
	return (self.state.value - 75.0) * (1.0 / 40.0);
