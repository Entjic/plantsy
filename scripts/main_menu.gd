extends Control

class_name MainMenu

var text_state = 0;
var has_game := false

signal start_game
signal new_game
signal pause_game

func _ready():
	pass;

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") && get_tree().paused == true && has_game == true:
		start();
	elif(Input.is_action_just_pressed("ui_cancel") && get_tree().paused == false):
		pause();

func _on_continue_button_pressed() -> void:
	start();

func _on_quit_button_pressed() -> void:
	get_tree().quit();

func _on_play_button_pressed() -> void:
	create_new();

func create_new():
	set_has_game(true)
	self.hide()
	new_game.emit()

func start():
	self.hide();
	start_game.emit()

func pause():
	self.show();
	pause_game.emit()

func set_has_game(state: bool):
	$VBoxContainer/ContinueButton.visible = state
	has_game = state;
	

func _on_tutorial_button_pressed() -> void:
	if(text_state == 0):
		$TextEdit.text = "Interact: 'E'\nPlant Infos: 'C'\nUse Item: 'F'"
		text_state = 1
	elif(text_state == 1):
		$TextEdit.text = "Play as a peaceful\nmonk tending to a\ngarden. Balance the\nplants' needs."
		text_state = 0
