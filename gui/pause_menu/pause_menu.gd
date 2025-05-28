extends CanvasLayer

const TITLE_SCREEN : String = "res://title_scene/title_scene.tscn"

signal shown
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button_save: Button = $Control/HBoxContainer/Save
@onready var button_quit: Button = $Control/HBoxContainer/Quit
@onready var item_description: Label = $Control/ItemDescription

var is_paused : bool = false 

func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect( on_save_pressed )
	button_quit.pressed.connect( on_quit_pressed )
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
	shown.emit()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false 
	hidden.emit()

func on_save_pressed() -> void: 
	if is_paused == false: 
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass

func on_quit_pressed() -> void:
	if is_paused == false: 
		return
	LevelManager.load_new_level( TITLE_SCREEN, "", Vector2.ZERO)
	hide_pause_menu()
	pass

func update_item_description( new_text : String ) -> void:
	item_description.text = new_text


func play_audio( audio : AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
