class_name LockedDoor extends Node2D

@export var key_item : ItemData 
@export var locked_audio : AudioStream 
@export var open_audio : AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var interact_area: Area2D = $InteractArea
@onready var is_open_data: PersistentDataHandler = $PersistentDataHandler


var is_open : bool = false 

func _ready() -> void:
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )
	is_open_data.data_loaded.connect( set_state )
	set_state()



func open_door() -> void:
	if key_item == null:
		return
	var door_unlocked = PlayerManager.INVENTORY_DATA.use_item( key_item )
	
	if door_unlocked:
		animation_player.play( "open_door" )
		audio.stream = open_audio
		is_open_data.set_value()
	else:
		audio.stream = locked_audio
	audio.play()
	pass



func close_door() -> void:
	animation_player.play( "close_door" )


func set_state() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play( "open" )
	else:
		animation_player.play( "closed" )


func _on_area_enter( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( open_door )


func _on_area_exit( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( open_door )
