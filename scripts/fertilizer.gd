extends Holdable

@onready var fertilizer_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child
var fertilizing:= false

func _ready():
	item_type = "fertilizer"

func _process(delta: float) -> void:
	if Input.is_action_just_released("use_item") && fertilizing:
		fert_stop()

func use(_node: Node, facing_direction: Vector2) -> void:
	var player := _node as Node2D  # Make sure we can access global_position

	for body in fertilizer_area.get_overlapping_bodies():
		# Only water bodies that have a water_level property
		if "fertilizer_level" in body.get_property_list().map(func(p): return p.name):
			# Direction from player to the body
			var to_body: Vector2 = (body.global_position - player.global_position).normalized()
			var facing: Vector2 = facing_direction.normalized()
			var alignment := facing.dot(to_body)

			# Require player to be roughly facing the body
			if alignment >= 0.7:
				body.fertilizer_level.value += 0.04
				if(!fertilizing):
					fert_start()
				break
			else:
				if  fertilizing:
					fert_stop()

func fert_stop():
	fertilizing = false
	if(direction == "right"):
		$AnimatedSprite2D.play("fert_stop_right")
	else:
		$AnimatedSprite2D.play("fert_stop_left")
		
func fert_start():
	fertilizing = true;
	if(direction == "right"):
		$AnimatedSprite2D.play("fert_start_right")
	else:
		$AnimatedSprite2D.play("fert_start_left")
	
