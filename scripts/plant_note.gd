extends Control

@onready var name_label = $VBoxContainer/NameLabel
@onready var description_label = $VBoxContainer/DescriptionLabel
@onready var background = $Background

func show_note(plant):
	if plant == null:
		hide()
		return
	
	name_label.text = "Type: " + str(plant.type)
		
	var desc_text := ""
	desc_text += "Water Level: " + format_level(plant.water_level) + "\n"
	desc_text += "Fertilizer Level: " + format_level(plant.fertilizer_level) + "\n"
	desc_text += "Pesticide Level: " + format_level(plant.pesticide_level) + "\n"
	desc_text += "State: %0.2f\n" % plant.state.value
	desc_text += "Health: %0.2f\n" % plant.health.value
	desc_text += "Worth: $%0.2f" % plant.worth.value
	
	description_label.text = desc_text
	
	show()

func hide_note():
	hide()

func format_level(level):
	return "%0.2f (min: %0.2f, max: %0.2f)" % [level.value, level.min, level.max]
