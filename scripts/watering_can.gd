extends Holdable

@onready var water_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child
var is_watering: bool = false
var water_amount: float = 5.0 # How much to water per second

func _ready():
	item_type = "watering_can"
	# Ensure you have an Area2D child named "Area2D" with a CollisionShape2D
	if water_area:
		water_area.body_entered.connect(_on_water_area_body_entered)
		water_area.body_exited.connect(_on_water_area_body_exited)
	else:
		printerr("Error: Area2D node not found as a child of WateringCan!")

func _process(delta: float) -> void:
	if is_watering and water_area:
		for body in water_area.get_overlapping_bodies():
			if body.is_in_group("plants"):
				if "increase_water" in body: # Ensure the plant has the function
					body.increase_water(water_amount * delta)

func use_item():
	is_watering = true

func stop_use():
	is_watering = false

func _on_water_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("plants"):
		print("Plant detected in watering area!")

func _on_water_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("plants"):
		print("Plant exited watering area.")
