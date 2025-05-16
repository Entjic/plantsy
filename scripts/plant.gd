extends Node2D

var hidration: float = 10.0  # Starts empty

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("plants")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Optional: Set a maximum water level
const MAX_WATER_LEVEL = 100.0

func increase_water(amount: float) -> void:
	hidration += amount
	hidration = clamp(hidration, 0, MAX_WATER_LEVEL)
	print("Water level: ", hidration)
