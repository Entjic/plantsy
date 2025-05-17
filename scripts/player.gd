extends CharacterBody2D

const SPEED = 60.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: Area2D = $PickupArea
@onready var ui: Control = $Camera2D/CanvasLayer/Interface

var held: Holdable = null

var bank: Bank = Bank.new()

var facing_direction: Vector2 = Vector2.DOWN  # Default facing

func _ready() -> void:
	ui.bank = bank

#
func _process(_delta):
	if held:
		held.position = Vector2(0, -16)


func _physics_process(_delta: float) -> void:
	var x_direction := Input.get_axis("move_left", "move_right")
	var y_direction := Input.get_axis("move_up", "move_down")

	var direction := Vector2(x_direction, y_direction)

	var speed_boost := 1
	var anim_speed := 1.0
	
	
	if Input.is_action_just_pressed("money_cheat"):
		bank.give(100)
	
	if Input.is_action_pressed("sneak"):
		speed_boost = 5
		anim_speed = 5.0

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED * speed_boost
		facing_direction = direction  # ✅ Save the last direction for later
		
		anim_sprite.speed_scale = anim_speed
		
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
	
	if Input.is_action_pressed("use_item") and held:
		held.use(self, facing_direction)

	move_and_slide()

	#todo hier body in area gucken und je nach type fuc aufrufen

	# Check for pickup or drop
	if Input.is_action_just_pressed("interact"):  # define this in Input Map
		for body in pickup_area.get_overlapping_bodies():
			if body is Holdable and held == null:
				pickup(body)
			elif body is HoldableSlot and held != null:
				drop(body)
			elif body is shop:
				buy(body)

	#if Input.is_action_just_pressed("ui_text_newline"):  #todo key
		#buy();

func pickup(body: Node):
	held = body
	held.pick_up(self)

func drop(body: Node):
	var slot: HoldableSlot = body
	if slot.can_accept(held, facing_direction, self):
		print("Can place " + held.name + " on slot")
		held.drop(self, facing_direction)
		slot.center(held)
		slot.empty = false
		held = null
		return
	else:
		print("Wrong slot for this item.")
	
func buy(body: Node):
	if held:
		return
	print("try")
			
			#money check
			#held = Shop.reciveItem();
