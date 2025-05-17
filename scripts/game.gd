extends Node2D

@onready var MainMenu = $CanvasLayer/MainMenu;

func _ready():
	get_tree().paused = true;

func _process(delta: float) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	var menu_base_width = MainMenu.size.x
	
	if screen_size.x < 1200:
		MainMenu.scale = Vector2(1.5, 1.5)
	else:
		MainMenu.scale = Vector2(3, 3)
	
	var left_half_center = Vector2(screen_size.x / 4, screen_size.y / 2)
	var scaled_size = MainMenu.size * MainMenu.scale
	MainMenu.position = left_half_center - scaled_size / 2


	
