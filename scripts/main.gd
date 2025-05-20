extends Node2D

class_name Main

@export var game_scene = Node2D;

@onready var main_menu: MainMenu = $CanvasLayer/MainMenu;
@onready var message_queue: MessageQueue = $CanvasLayer/MessageQueue;
@onready var game_over_screen: GameOverScreen = $CanvasLayer/GameOverScreen;
@onready var progress_bar: ProgressBar = $CanvasLayer/Progress/ProgressBar
@onready var progress_label: Label = $CanvasLayer/Progress/ProgressLabel
@onready var game: Game = $Game;
@onready var timer = $GameTimer;

@export var PLAY_TIME = 600;

func _ready():
	get_tree().root.connect("size_changed", self._on_size_changed)
	
	self.set_mainmenu_size();
	get_tree().paused = true;
	game_over_screen.visible = false;

func _process(_delta: float) -> void:
	progress_bar.max_value = PLAY_TIME
	progress_bar.value = timer.time_left
	
	progress_label.text = Util.format_time(timer.time_left)
	
func _on_size_changed():
	self.set_mainmenu_size()

func set_mainmenu_size():
	var screen_size = get_viewport().get_visible_rect().size
	var menu_base_width = main_menu.size.x
	
	if screen_size.x < 1200:
		main_menu.scale = Vector2(1.5, 1.5)
	else:
		main_menu.scale = Vector2(3, 3)
	
	var left_half_center = Vector2(screen_size.x / 4, screen_size.y / 2)
	var scaled_size = main_menu.size * main_menu.scale
	main_menu.position = left_half_center - scaled_size / 2

func start():
	get_tree().paused = false;
	progress_bar.show()
	
func create_new():
	get_tree().paused = false;
	
	game.queue_free()
	
	var scene = load("res://scenes/Game.tscn")
	game = scene.instantiate()
	add_child(game)
	
	timer.start(PLAY_TIME)
	
	start()
	
func pause():
	get_tree().paused = true;
	progress_bar.hide()


func _on_main_menu_new_game() -> void:
	create_new()


func _on_main_menu_pause_game() -> void:
	pause()


func _on_main_menu_start_game() -> void:
	start()


func _on_game_timer_timeout() -> void:
	var player: Player = game.get_node("Player")
	game_over_screen.set_score(player.bank.balance)
	game_over_screen.visible = true
	
	main_menu.set_has_game(false)
	pause()


func _on_game_over_screen_back_to_menu() -> void:
	main_menu.show()
	game_over_screen.hide()
