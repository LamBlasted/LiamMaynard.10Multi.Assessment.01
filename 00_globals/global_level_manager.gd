extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChanged( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset : Vector2

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()

func ChangeTilemapBounds( bounds : Array[ Vector2 ]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit( bounds )

func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2
) -> void:
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
<<<<<<< HEAD
	#await SceneTransition.fade_out()
	
=======
>>>>>>> 34b6a7394294db1a866c9eddab969a419949a0fb
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( level_path )
	
<<<<<<< HEAD
	#await SceneTransition.fade_in()
	
=======
>>>>>>> 34b6a7394294db1a866c9eddab969a419949a0fb
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	
	
	pass
