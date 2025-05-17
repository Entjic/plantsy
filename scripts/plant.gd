extends Holdable

var water_level: WaterLevel = WaterLevel.new()
var fertilizer_level: FertilizerLevel = FertilizerLevel.new()
var health: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	item_type = "plant"

func _on_timer_timeout() -> void:
	water_level.tick()
	fertilizer_level.tick()
	# todo: reduce health if plant is unhappy
	print(self.name + ", water: " + str(self.water_level.value)
	+ " fertilizer: " + str(self.fertilizer_level.value))
