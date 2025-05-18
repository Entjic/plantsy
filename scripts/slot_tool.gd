@tool
extends HoldableSlot

@export_enum("left1", "left2", "middle", "right") var animation_state: String = "left":
	set(value):
		animation_state = value
		update_child_animation()
	get:
		return animation_state

func update_child_animation():
	var sprite = $AnimatedSprite2D
	if sprite == null:
		return

	sprite.animation = animation_state

	# Start playing to see animation in editor
	if Engine.is_editor_hint():
		sprite.play()

func _ready():
	accepted_holdables = ["fertilizer", "pesticide", "watering_can"]
	
