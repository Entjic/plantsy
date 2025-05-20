extends Control

class_name GameOverScreen

signal back_to_menu

func set_score(score: float):
	$VBoxContainer/ScoreLabel.text = "Score: $%0.2f" % score


func _on_quit_button_pressed() -> void:
	get_tree().quit();


func _on_back_button_pressed() -> void:
	back_to_menu.emit()
