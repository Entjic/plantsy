extends CharacterBody2D

const SPEED = 300.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	var direction := Vector2(x_direction, y_direction)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED

		# Determine animation based on movement direction
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
