extends shop

@export var plant_scene: PackedScene

func _ready():
	itemType = 'cactus'
	item = plant_scene
	price = 10.0
