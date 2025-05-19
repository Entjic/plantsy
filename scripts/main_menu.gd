extends Control

var text_state = 0;

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


func _on_tutorial_button_pressed() -> void:
	if(text_state == 0):
		$TextEdit.text = "Interact: 'E'\nPlant Infos: 'C'\nUse Item: 'F'"
		text_state = 1
	elif(text_state == 1):
		$TextEdit.text = "Play as a peaceful\nmonk tending to a\ngarden. Balance the\nplants' needs."
		text_state = 0
