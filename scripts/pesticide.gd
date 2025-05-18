extends Holdable

@onready var pestecide_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child
var pesting = false;

func _ready():
	item_type = "pesticide"

func _process(delta: float) -> void:
	if Input.is_action_just_released("use_item") && pesting:
		pest_stop()
	elif !pesting:
		if(direction == "right"):
			$AnimatedSprite2D.play("pest_right")
		else:
			$AnimatedSprite2D.play("pest_left")

func use(_node: Node, facing_direction: Vector2) -> void:
	var player := _node as Node2D  # Make sure we can access global_position

	for body in pestecide_area.get_overlapping_bodies():
		# Only water bodies that have a water_level property
		if "pesticide_level" in body.get_property_list().map(func(p): return p.name):
			# Direction from player to the body
			var to_body: Vector2 = (body.global_position - player.global_position).normalized()
			var facing: Vector2 = facing_direction.normalized()
			var alignment := facing.dot(to_body)

			# Require player to be roughly facing the body
			if alignment >= 0.7:
				body.pesticide_level.value += 0.04
				if(!pesting):
					pest_start()
				break
			else:
				if  pesting:
					pest_stop()

func pest_stop():
	pesting = false
	$Pssshht.stop()
	if(direction == "right"):
		$AnimatedSprite2D.play("pest_stop_right")
	else:
		$AnimatedSprite2D.play("pest_stop_left")

func pest_start():
	pesting = true;
	$Pssshht.play()
	if(direction == "right"):
		$AnimatedSprite2D.play("pest_start_right")
	else:
		$AnimatedSprite2D.play("pest_start_left")
	
