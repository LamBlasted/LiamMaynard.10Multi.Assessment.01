extends Node2D

const START_LEVEL : String = "res://levels/area01/01.tscn"

@onready var button_new: Button = $CanvasLayer/Control/New
@onready var button_quit: Button = $CanvasLayer/Control/Quit
@onready var button_continue : Button = $CanvasLayer/Control/Continue



func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false 
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED 
	
	if SaveManager.get_save_file() == null:
		button_continue.disabled = true
		button_continue.visible = false
	
	setup_title_scene()
	
	LevelManager.level_load_started.connect( exit_title_screen )
	
	pass


func setup_title_scene() -> void: 
	button_new.pressed.connect( start_game )
	button_quit.pressed.connect( quit_game )
	button_continue.pressed.connect( load_game )
	
	button_new.grab_focus()
	pass


func start_game() -> void: 
	LevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	pass

func load_game() -> void:
	SaveManager.load_game()
	pass

func exit_title_screen() -> void:
	PlayerManager.player.visible = true 
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	self.queue_free()
	pass


func quit_game() -> void: 
	get_tree().quit()
	pass
