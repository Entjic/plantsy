class_name PlantHealth
extends PlantProperty

var state: PlantState

func _init(state: PlantState):
	self.state = state
	value = 100.0


func progress(current: float) -> float:
	return (60.0 - self.state.value) * (1 / 1000);
