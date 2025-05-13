extends Node2D

@onready var button_new: Button = $CanvasLayer/Control/New
@onready var button_quit: Button = $CanvasLayer/Control/Quit
@onready var button_continue : Button = $CanvasLayer/Control/Continue



func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false 
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED 
	
	setup_title_scene()
	
	LevelManager.level_load_started.connect( exit_title_screen )
	
	pass


func setup_title_scene() -> void: 
	button_continue.pressed.connect( load_game )
	
	button_new.grab_focus()
	pass


func start_game() -> void: 
	
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



func _on_quit_pressed() -> void:
	get_tree().quit()
	pass
