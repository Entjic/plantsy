extends Node2D

@onready var MainMenu = $MainMenu;

func _ready():
	get_tree().paused = true;

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().paused = true;
		#$MainMenu.show();
		#print("esc game");

#func _on_main_menu_start_pressed() -> void:
	#get_tree().paused = false;
