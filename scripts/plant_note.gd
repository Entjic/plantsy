extends Control

@onready var name_label = $Panel/NameLabel
@onready var description_label = $Panel/DescriptionLabel
@onready var icon_texture = $Panel/IconTextureRect  # optional

func show_note(plant: Node2D):
	name_label.text = plant.name
	description_label.text = plant.description if plant.has_method("description") else "No info."
	if icon_texture and plant.has_method("get_icon"):
		icon_texture.texture = plant.get_icon()

	show()
