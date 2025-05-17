extends Holdable

var water_level: WaterLevel = WaterLevel.new()
var fertilizer_level: FertilizerLevel = FertilizerLevel.new()
var pesticide_level: PestecideLevel = PestecideLevel.new()
var state: PlantState = PlantState.new([self.water_level, self.fertilizer_level])
var health: PlantHealth = PlantHealth.new(self.state)
var type:= "sunflower"

@onready var PlantBottom = $PlantBottom;
@onready var PlantTop = $PlantTop;
@onready var PlantPot = $PlantPot;

@onready var InspectionArea = $InspectionArea;
@onready var InspectionInfo = $InspectionInfo;
@onready var StateLabel = $InspectionInfo/StateLabel;
@onready var ArrowSprite = $InspectionInfo/ArrowSprite;

# Called when the node enters the scene tree for the first time.
func _ready():
	setTextures()

func _on_timer_timeout() -> void:
	water_level.tick()
	fertilizer_level.tick()
	pesticide_level.tick()
	state.tick()
	health.tick()
	# todo: reduce health if plant is unhappy
	print(self.name
	+ ", water: " + str(Util.round_with_decimals(self.water_level.value, 2))
	+ " fertilizer: " + str(Util.round_with_decimals(self.fertilizer_level.value, 2))
	+ " pestecide: " + str(Util.round_with_decimals(self.pesticide_level.value, 2))
	+ " -> state: " + str(Util.round_with_decimals(self.state.value, 2))
	+ " => ♥: " + str(Util.round_with_decimals(self.health.value, 2)))
	
	StateLabel = str(Util.round_with_decimals(self.state.value - 75.0, 2))

func setTextures():
	if(type == 'cactus'):
		$PlantTop.play('plant_1')
		$PlantBottom.play('plant_1')
		$PlantPot.play('pink')
		
	elif(type == 'sunflower'):
		$PlantTop.play('plant_2')
		$PlantBottom.play('plant_2')
		$PlantPot.play('pink')
	
func _process(delta: float) -> void:
	self.update_show_info()

func update_show_info():
	for body in self.InspectionArea.get_overlapping_bodies():
		if body is CharacterBody2D:
			InspectionInfo.visible = true
			return
	InspectionInfo.visible = false
