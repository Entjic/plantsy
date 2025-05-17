extends StaticBody2D

@export var itemType: String;
@export var item: PackedScene;
@export var price: float;

@onready var shopTexture = $shopTexture;

func _ready():
	price = 10.0
	setTexture()

func setTexture():
	if(itemType == "cactus"):
		$shopTexture.play("cactus")
	if(itemType == "orange"):
		$shopTexture.play("orange")
	if(itemType == "purple"):
		$shopTexture.play("purple")
	if(itemType == "red"):
		$shopTexture.play("red")
	if(itemType == "rose"):
		$shopTexture.play("rose")
	if(itemType == "sunflower"):
		$shopTexture.play("sunflower")

func reciveItem() -> Holdable:
	print(itemType + " gekauft")
	if item:
		var new_item = item.instantiate() as Holdable
		new_item.type = itemType
		new_item.setTextures()
		return new_item
	else:
		print("Fehler: Kein Item definiert")
		return null
