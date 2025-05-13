extends Node2D

@onready var button_new: Button = $CanvasLayer/Control/New
@onready var button_quit: Button = $CanvasLayer/Control/Quit
@onready var button_continue : Button = $CanvasLayer/Control/Continue



func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false 
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED 
	
	pass


func exit_title_screen() -> void:
	PlayerManager.player.visible = false 
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	self.queue_free()
	pass



func _on_quit_pressed() -> void:
	get_tree().quit()
	pass
