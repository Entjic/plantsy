extends Holdable

@onready var water_area: Area2D = $Area2D  # Assuming you'll add an Area2D as a child
var watering:= false

func _ready():
	item_type = "watering_can"

func _process(delta: float) -> void:
	if Input.is_action_just_released("use_item") && watering:
		water_stop()
	elif !watering:
		if(direction == "right"):
			$AnimatedSprite2D.play("water_right")
		else:
			$AnimatedSprite2D.play("water_left")

func use(_node: Node, facing_direction: Vector2) -> void:
	var player := _node as Node2D  # Make sure we can access global_position
	for body in water_area.get_overlapping_bodies():
		# Only water bodies that have a water_level property
		if "water_level" in body.get_property_list().map(func(p): return p.name):
			# Direction from player to the body
			var to_body: Vector2 = (body.global_position - player.global_position).normalized()
			var facing: Vector2 = facing_direction.normalized()
			var alignment := facing.dot(to_body)

			# Require player to be roughly facing the body
			if alignment >= 0.7:
				if(!watering):
					water_start()
				body.water_level.value += 0.04
				break
			else:
				if  watering:
					water_stop()

func water_stop():
	watering = false
	$SplishSplash.stop()
	if(direction == "right"):
		$AnimatedSprite2D.play("water_stop_right")
	else:
		$AnimatedSprite2D.play("water_stop_left")

func water_start():
	watering = true;
	if not $SplishSplash.playing:
		$SplishSplash.play()
	if(direction == "right"):
		$AnimatedSprite2D.play("water_start_right")
	else:
		$AnimatedSprite2D.play("water_start_left")
	
