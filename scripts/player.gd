extends CharacterBody2D

const SPEED = 60.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: Area2D = $PickupArea

var held: Holdable = null

var facing_direction: Vector2 = Vector2.DOWN  # Default facing

#
func _process(_delta):
	if held:
		held.position = Vector2(0, -16)


func _physics_process(_delta: float) -> void:
	var x_direction := Input.get_axis("move_left", "move_right")
	var y_direction := Input.get_axis("move_up", "move_down")

	var direction := Vector2(x_direction, y_direction)

	var speed_boost := 1
	
	if Input.is_action_pressed("sneak"):
		speed_boost = 5

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED * speed_boost
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
			print("picking up smth")
			held.pick_up(self)
			break

func drop():
	if held:
		held.drop(self, facing_direction)
		print("dropping smth")
		held = null
