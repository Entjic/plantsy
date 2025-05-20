extends Control

class_name MessageQueue

@onready var label = $ErrorLabel
var display_time := 2.5  # seconds to show each message
var queue := []
var showing := false
var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	label.visible = false

func show_message(text: String):
	queue.append(text)
	print("showing message..")
	if not showing:
		_next_message()

func _next_message():
	print("next message")
	if queue.size() == 0:
		print("nothing in queue")
		showing = false
		label.visible = false
		return

	var next_text = queue.pop_front()
	print("next to display: " + next_text)
	label.text = next_text
	label.visible = true
	showing = true
	timer.start(display_time)

func _on_timer_timeout():
	_next_message()
