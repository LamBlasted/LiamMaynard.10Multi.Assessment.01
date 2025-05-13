extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Save
@onready var button_quit: Button = $VBoxContainer/Quit

var is_paused : bool = false 

func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect( on_save_pressed )
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
	pass

func show_pause_menu() -> void: 
	get_tree().paused = true
	visible = true
	is_paused = true 

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false 

func on_save_pressed() -> void: 
	if is_paused == false: 
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass
