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
		facing_direction = direction
		
		anim_sprite.speed_scale = anim_speed
		
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim_sprite.play("right")
				if(held):
					held.direction = 'right'
			else:
				anim_sprite.play("left")
				if(held):
					held.direction = 'left'
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
	
	if Input.is_action_just_pressed("analyze"):
		
		var note_ui = get_tree().get_root().get_node("Game/CanvasLayer/PlantNote")
		if note_ui.visible:
			note_ui.hide()
		else: 
			for body in pickup_area.get_overlapping_bodies():
				if body is not Holdable or body.item_type != "plant":
					continue
				
				var to_body: Vector2 = (body.global_position - self.global_position).normalized()
				var facing: Vector2 = facing_direction.normalized()
				var alignment := facing.dot(to_body)

				# Require player to be roughly facing the body
				if alignment >= 0.7:
					print("found match")
					note_ui.show_note(body)
			
	if Input.is_action_just_pressed("interact"):
		for body in pickup_area.get_overlapping_bodies():
			if body is Holdable and held == null:
				pickup(body)
			elif body is HoldableSlot and held != null:
				drop(body)
			elif body.get_scene_file_path() == 'res://scenes/Shop.tscn':
				buy(body)

func pickup(body: Node):
	held = body
	held.pick_up(self)

func drop(body: Node):
	var slot: HoldableSlot = body
	if slot.can_accept(held, facing_direction, self):
		if slot is DeliveryLocation and self.held is Plant: 
			var plnt: Plant = self.held
			if (plnt.age.value < 24):
				return
			
		print("Can place " + held.name + " on slot")
		held.drop(self, facing_direction, slot)
		slot.center(held)
		slot.held = self.held
		
		if slot is DeliveryLocation and self.held is Plant: 
			var dl: DeliveryLocation = slot
			var plnt: Plant = self.held
			if plnt.age.value >= 24:
				dl.pay(bank, plnt)
			return
		
		self.held = null
		return
	else:
		print("Wrong slot for this item.")
	
func buy(shop: Node):
	if held:
		print("you are already holding item :(")
		return

	if bank.pay(shop.price):
		var item = shop.reciveItem()
		get_tree().current_scene.add_child(item)
		item.pick_up(self)
		held = item
