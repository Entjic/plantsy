extends Control

func _ready():
	pass;

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") && get_tree().paused == true:
		start_game();
	elif(Input.is_action_just_pressed("ui_cancel") && get_tree().paused == false):
		pause_game();
	
	
	

func _on_quit_button_pressed() -> void:
	get_tree().quit();

func _on_play_button_pressed() -> void:
	start_game();
	
func start_game():
	self.hide();
	get_tree().paused = false;
	
func pause_game():
	self.show();
	get_tree().paused = true;
