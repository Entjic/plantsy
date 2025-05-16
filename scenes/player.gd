extends CharacterBody2D

const SPEED = 300.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: Area2D = $PickupArea

var carried_flower: Node2D = null

func _physics_process(_delta: float) -> void:
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	var direction := Vector2(x_direction, y_direction)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED

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
		if carried_flower:
			drop_flower()
		else:
			pickup_flower()


func pickup_flower():
	for body in pickup_area.get_overlapping_bodies():
		if body.is_in_group("flowers"):
			carried_flower = body
			carried_flower.get_parent().remove_child(carried_flower)
			add_child(carried_flower)
			carried_flower.position = Vector2(0, -16)  # Offset above player
			break

func drop_flower():
	if carried_flower:
		remove_child(carried_flower)
		get_parent().add_child(carried_flower)
		carried_flower.global_position = global_position + Vector2(0, 16)
		carried_flower = null
