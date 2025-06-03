extends CanvasLayer


var hearts : Array[ HeartGUI ] = []

@onready var game_over: Control = $GameOver
@onready var continue_button: Button = $GameOver/VBoxContainer/Continue
@onready var quit_button: Button = $GameOver/VBoxContainer/Quit
@onready var animation_player: AnimationPlayer = $GameOver/AnimationPlayer




func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false
	
	continue_button.pressed.connect( load_game )
	quit_button.pressed.connect( quit_game )
	LevelManager.level_load_started.connect( hide_game_over_screen )

	pass 



func update_hp( _hp: int, _max_hp: int ) -> void:
	update_max_hp( _max_hp )
	for i in _max_hp:
		update_heart( i, _hp )
	pass


func update_heart( _index : int, _hp : int ) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[ _index ].value = _value
	pass


func update_max_hp( _max_hp: int ) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else: 
			hearts[i].visible = false
	pass


func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var can_continue : bool = SaveManager.get_save_file() != null
	continue_button.visible = can_continue
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
	
	if can_continue == true:
		continue_button.grab_focus()
	else:
		quit_button.grab_focus()

func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color( 1,1,1,0 )

func load_game() -> void:
	await fade_to_black()
	SaveManager.load_game()

func quit_game() -> void:
	await fade_to_black()
	LevelManager.load_new_level( "res://title_scene/title_scene.tscn", "", Vector2.ZERO )

func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.revive_player()
	return true
