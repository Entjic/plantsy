extends Holdable

var water_level: float = 100.0  # Starts empty
var health: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("plants")
	item_type = "flower"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



# Optional: Set a maximum water level
const MAX_WATER_LEVEL = 100.0

func increase_water(amount: float) -> void:
	self.water_level += amount
	self.water_level = clamp(self.water_level, 0, MAX_WATER_LEVEL)
	print("Water level: ", self.water_level)


func _on_timer_timeout() -> void:
	self.water_level -= (1.0 / 40.0) * log(self.water_level + 1)
	self.water_level = clamp(self.water_level, 0, MAX_WATER_LEVEL)

	# todo: reduce health if plant is unhappy
	print(self.name + ", waterlevel: " + str(self.water_level))
