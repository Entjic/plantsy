extends Control

@onready var name_label = $VBoxContainer/NameLabel
@onready var type_label = $VBoxContainer/TypeLabel
@onready var description_label = $VBoxContainer/DescriptionLabel

@onready var money_label = $VBoxContainer/VBoxContainer/Money/MoneyLabel
@onready var water_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn1/Water/WaterLabel
@onready var fertilizer_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn2/Fertilizer/FertilizerLabel
@onready var pesticide_label = $VBoxContainer/VBoxContainer/HBoxContainer/PropertyColumn1/Pesticide/PesticideLabel

@onready var background = $Background

func show_note(plant: Plant):
	if plant == null:
		hide()
		return
	
	name_label.text = plant.plant_name
	type_label.text = "Art: " + str(plant.type)
	
	money_label.text = "$%0.2f" % plant.worth.value
	water_label.text = format_level_2(plant.water_level)
	fertilizer_label.text = format_level_2(plant.fertilizer_level)
	pesticide_label.text = format_level_2(plant.pesticide_level)
	
	show()

func hide_note():
	hide()

func format_level(level):
	return "%0.2f (min: %0.2f, max: %0.2f)" % [level.value, level.min, level.max]

func format_level_2(level):
	return "%0.1f/%0.0f" % [level.value, level.max]
	
