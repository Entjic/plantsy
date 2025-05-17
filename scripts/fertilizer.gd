extends Holdable

@onready var fertilizer_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child

func _ready():
	item_type = "fertilizer"

func use(node: Node) -> void:
	for body in fertilizer_area.get_overlapping_bodies():
		if "fertilizer_level" in body.get_property_list().map(func(p): return p.name):
			body.fertilizer_level.value += 0.04
