extends Holdable

var water_level: WaterLevel = WaterLevel.new()
var fertilizer_level: FertilizerLevel = FertilizerLevel.new()
var state: PlantState = PlantState.new([self.water_level, self.fertilizer_level])
var health: PlantHealth = PlantHealth.new(self.state)
var type:= "sunflower"

@onready var PlantBottom = $PlantBottom;
@onready var PlantTop = $PlantTop;
@onready var PlantPot = $PlantPot;

# Called when the node enters the scene tree for the first time.
func _ready():
	setTextures()

func _on_timer_timeout() -> void:
	water_level.tick()
	fertilizer_level.tick()
	state.tick()
	health.tick()
	# todo: reduce health if plant is unhappy
	print(self.name
	+ ", water: " + str(Util.round_with_decimals(self.water_level.value, 2))
	+ " fertilizer: " + str(Util.round_with_decimals(self.fertilizer_level.value, 2))
	+ " -> state: " + str(Util.round_with_decimals(self.state.value, 2))
	+ " => ♥: " + str(Util.round_with_decimals(self.health.value, 2)))

func setTextures():
	if(type == 'cactus'):
		$PlantTop.play('plant_1')
		$PlantBottom.play('plant_1')
		$PlantPot.play('pink')
		
	elif(type == 'sunflower'):
		$PlantTop.play('plant_2')
		$PlantBottom.play('plant_2')
		$PlantPot.play('pink')
	
	
