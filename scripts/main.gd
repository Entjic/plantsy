extends Node2D

class_name Main

@export var game_scene = Node2D;

@onready var main_menu: MainMenu = $CanvasLayer/MainMenu;
@onready var message_queue: MessageQueue = $CanvasLayer/MessageQueue;
@onready var game: Game = $Game;
@onready var timer = $GameTimer;

func _ready():
	get_tree().root.connect("size_changed", self._on_size_changed)
	
	self.set_mainmenu_size();
	get_tree().paused = true;

func _process(_delta: float) -> void:
	pass;

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
	
func create_new():
	get_tree().paused = false;
	
	game.queue_free()
	
	var scene = load("res://scenes/Game.tscn")
	game = scene.instantiate()
	add_child(game)
	
func pause():
	get_tree().paused = true;


func _on_main_menu_new_game() -> void:
	create_new()


func _on_main_menu_pause_game() -> void:
	pause()


func _on_main_menu_start_game() -> void:
	start()
