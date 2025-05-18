extends Control

@onready var name_label = $VBoxContainer/NameLabel
@onready var type_label = $VBoxContainer/TypeLabel
@onready var description_label = $VBoxContainer/DescriptionLabel

@onready var money_label = $VBoxContainer/VBoxContainer/Money/MoneyLabel
@onready var water_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn1/Water/WaterLabel
@onready var fertilizer_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn2/Fertilizer/FertilizerLabel
@onready var pesticide_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn1/Pesticide/PesticideLabel
@onready var health_label = $VBoxContainer/VBoxContainer/HBoxContainer2/PropertyColumn1/Health/HealthLabel
@onready var state_label = $VBoxContainer/VBoxContainer/HBoxContainer2/PropertyColumn2/State/StateLabel
@onready var age_label = $VBoxContainer/VBoxContainer/HBoxContainer2/PropertyColumn1/Age/AgeLabel
@onready var arrow_sprite = $VBoxContainer/VBoxContainer/HBoxContainer2/PropertyColumn2/State/StateArrowSprite

@onready var background = $Background

var plant: Plant

func show_note(plant: Plant):
	self.plant = plant
	update_plant()
	self.plant.set_note_function(update_plant)
	
func update_plant():
	if plant == null:
		hide()
		return
	
	name_label.text = plant.plant_name
	type_label.text = "Type: " + str(plant.type)
	
	money_label.text = "$%0.2f" % plant.worth.value
	water_label.text = format_level_2(plant.water_level)
	fertilizer_label.text = format_level_2(plant.fertilizer_level)
	pesticide_label.text = format_level_2(plant.pesticide_level)
	
	health_label.text = format_level_2(plant.health)
	money_label.text = "$%0.2f" % plant.worth.value
	
	var state_transformed = (plant.state.value - 75.0) * (1.0 / 20.0)
	var state_text = str(Util.round_with_decimals(state_transformed, 2))
	
	if state_transformed > 0:
		state_label.text = "+" + state_text
		arrow_sprite.animation = "green"
	else:
		state_label.text = state_text
		arrow_sprite.animation = "red"	
	
	show()

func hide_note():
	if plant:
		plant.unset_note_function()
	hide()

func format_level(level):
	return "%0.2f (min: %0.2f, max: %0.2f)" % [level.value, level.min, level.max]

func format_level_2(level):
	return "%0.1f/%0.0f" % [level.value, level.max]
	
