class_name Plant
extends Holdable

var water_level: WaterLevel = WaterLevel.new()
var fertilizer_level: FertilizerLevel = FertilizerLevel.new()
var pesticide_level: PestecideLevel = PestecideLevel.new()
var state: PlantState = PlantState.new([self.water_level, self.fertilizer_level])
var health: PlantHealth = PlantHealth.new(self.state)
var worth: PlantWorth = PlantWorth.new(self.health)
var type:= "sunflower"

@onready var PlantTexture = $PlantTexture;

@onready var InspectionArea = $InspectionArea;
@onready var InspectionInfo = $InspectionInfo;
@onready var StateLabel = $InspectionInfo/StateLabel;
@onready var ArrowSprite = $InspectionInfo/ArrowSprite;
@onready var HealthBarPath = $InspectionInfo/HealthBarSprite/Path2D/PathFollow2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	setTextures()

func _on_timer_timeout() -> void:
	water_level.tick()
	fertilizer_level.tick()
	pesticide_level.tick()
	state.tick()
	health.tick()
	worth.tick()
	# todo: reduce health if plant is unhappy
	print(self.name
	+ ", water: " + str(Util.round_with_decimals(self.water_level.value, 2))
	+ " fertilizer: " + str(Util.round_with_decimals(self.fertilizer_level.value, 2))
	+ " pestecide: " + str(Util.round_with_decimals(self.pesticide_level.value, 2))
	+ " -> state: " + str(Util.round_with_decimals(self.state.value, 2))
	+ " => ♥: " + str(Util.round_with_decimals(self.health.value, 2))
	+ " ($: " + str(Util.round_with_decimals(self.worth.value, 2)) + ")")

	
	var state_transformed = self.state.value - 75.0
	var state_text = str(Util.round_with_decimals(state_transformed, 2))
	
	if state_transformed > 0:
		StateLabel.text = "+" + state_text
		ArrowSprite.animation = "green"
	else:
		StateLabel.text = state_text
		ArrowSprite.animation = "red"
	
	HealthBarPath.progress_ratio = 1.0 - (self.health.value / 100)

func setTextures():
	item_type = "plant"
	if(type == 'cactus'):
		$PlantTexture.play('cactus')
	elif(type == 'sunflower'):
		$PlantTexture.play('sunflower')
	elif(type == 'orange'):
		$PlantTexture.play('orange')
	elif(type == 'purple'):
		$PlantTexture.play('purple')
	elif(type == 'red'):
		$PlantTexture.play('red')
	elif(type == 'rose'):
		$PlantTexture.play('rose')
	
func _process(delta: float) -> void:
	self.update_show_info()

func update_show_info():
	for body in self.InspectionArea.get_overlapping_bodies():
		if body is CharacterBody2D:
			InspectionInfo.visible = true
			return
	InspectionInfo.visible = false
