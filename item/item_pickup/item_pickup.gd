@tool
class_name ItemPickup extends CharacterBody2D

signal picked_up

@export var item_data : ItemData : set = _set_item_data


@onready var area: Area2D = $Area2D
@onready var sprite2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area.body_entered.connect( _on_body_entered )

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide( velocity * delta )
	if collision_info:
		velocity = velocity.bounce( collision_info.get_normal() )
	velocity -= velocity * delta * 8

func _on_body_entered(b) -> void:
	if b is Player:
		if item_data:
			if item_data.consume_on_pickup:
				for effect in item_data.effects:
					if effect.has_method("on_pickup"):
						effect.on_pickup()
				item_picked_up()
			else:
				if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
					item_picked_up()



func item_picked_up() -> void:
	area.body_entered.disconnect( _on_body_entered )
	audio_stream_player.play()
	visible = false 
	picked_up.emit()
	await audio_stream_player.finished
	queue_free()
	pass


func _set_item_data( value: ItemData ) -> void:
	item_data = value
	_update_texture()
	pass

func _update_texture() -> void:
	if item_data and sprite2d:
		sprite2d.texture = item_data.texture
	pass
