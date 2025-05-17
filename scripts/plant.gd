extends Holdable

var water_level: WaterLevel = WaterLevel.new()
var fertilizer_level: FertilizerLevel = FertilizerLevel.new()
var state: PlantState = PlantState.new([self.water_level, self.fertilizer_level])
var health: PlantHealth = PlantHealth.new(self.state)

# Called when the node enters the scene tree for the first time.
func _ready():
	item_type = "plant"

func _on_timer_timeout() -> void:
	water_level.tick()
	fertilizer_level.tick()
	state.tick()
	health.tick()
	# todo: reduce health if plant is unhappy
	print(self.name + ", water: " + str(self.water_level.value)
	+ " fertilizer: " + str(self.fertilizer_level.value) + " -> state: " + str(self.state.value) + " => ♥: " + str(self.health.value))
