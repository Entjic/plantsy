extends Holdable

@onready var water_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child

func _ready():
	item_type = "watering_can"

func use(_node: Node) -> void:
	for body in water_area.get_overlapping_bodies():
		if "water_level" in body.get_property_list().map(func(p): return p.name):
			var anim_player := $AnimatedSprite2D
			anim_player.play("water")
			body.water_level.value += 0.04
			break;
