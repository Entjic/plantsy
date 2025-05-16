extends CharacterBody2D

const SPEED = 300.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: Area2D = $PickupArea

var held: Holdable = null

var facing_direction: Vector2 = Vector2.DOWN  # Default facing


func _process(_delta):
	if held:
		held.position = Vector2(0, -16)


func _physics_process(_delta: float) -> void:
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	var direction := Vector2(x_direction, y_direction)


	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
		facing_direction = direction  # ✅ Save the last direction for later

		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim_sprite.play("right")
			else:
				anim_sprite.play("left")
		else:
			if direction.y > 0:
				anim_sprite.play("down")
			else:
				anim_sprite.play("up")

	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		anim_sprite.stop()

	move_and_slide()

	# Check for pickup or drop
	if Input.is_action_just_pressed("interact"):  # define this in Input Map
		if held:
			drop()
		else:
			pickup()


func pickup():
	for body in pickup_area.get_overlapping_bodies():
		if body is Holdable and held == null:
			held = body
			
			# Save original collision settings
			held.carried_layer = held.collision_layer
			held.carried_mask = held.collision_mask
			held.carried_z_index = held.z_index  # Save original z-index
			held.z_index = 100  # High value so it's above the player

			# Re-parent to player
			held.get_parent().remove_child(held)
			add_child(held)
			held.position = Vector2(0, -16)
			held.z_index = 1
			held.visible = true
			# Disable collision and physics while carried
			if held.has_method("set_physics_process"):
				held.set_physics_process(false)
			held.collision_layer = 0
			held.collision_mask = 0
			break

func drop():
	if held:
		var parent_node = get_tree().get_root().get_node("Game/Plants")
		remove_child(held)
		parent_node.add_child(held)

		# 🧭 Drop it in the direction you're facing
		var drop_offset := facing_direction.normalized() * 20
		held.global_position = global_position + drop_offset
		held.z_index = held.carried_z_index  # Restore previous z
		# Restore original collision and physics
		held.set_physics_process(true)
		held.collision_layer = held.carried_layer
		held.collision_mask = held.carried_mask

		held = null
