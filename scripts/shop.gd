extends StaticBody2D

@export var itemType: String;
@export var item: PackedScene;
@export var price: float;

@onready var shopTexture = $shopTexture;
#var types = ['cactus', 'orange', 'purple', 'red', 'rose', 'sunflower']

func _ready():
	price = randi_range(1, 6)
	$InspectionInfo/Label.text = "Price: " + str(price)
	setTexture()

func _process(delta: float) -> void:
	update_show_info()

func setTexture():
	match itemType:
		'cactus', 'orange', 'purple', 'red', 'rose', 'sunflower':
			$shopTexture.play(itemType)

func reciveItem() -> Holdable:
	get_tree().get_root().get_node("Game/CanvasLayer/MessageQueue").show_message(itemType + " received")

	if item:
		var new_item = item.instantiate() as Holdable
		new_item.type = itemType
		new_item.setTextures()
		return new_item
	else:
		print("Fehler: Kein Item definiert")
		return null

func update_show_info():
	for body in $InspectionArea.get_overlapping_bodies():
		if body is CharacterBody2D:
			$InspectionInfo.visible = true
			return
	$InspectionInfo.visible = false
