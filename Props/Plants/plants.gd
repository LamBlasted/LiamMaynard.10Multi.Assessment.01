class_name Plant extends Node2D

const PICKUP = preload("res://item/item_pickup/item_pickup.tscn")

@export_category("Item Drops")
@export var drops : Array[DropData] = []

func _ready():
	$hitbox.damaged.connect(take_damage)

func take_damage(_hurt_box: HurtBox) -> void:
	drop_items()
	queue_free()

func drop_items() -> void:
	if drops.is_empty():
		return
	
	for i in drops.size():
		if drops[ i ] == null or drops[ i ].item == null: 
			continue
		var drop_count : int = drops[ i ].get_drop_count()
		for j in drop_count:
			var drop: ItemPickup = PICKUP.instantiate()
			drop.item_data = drops[ i ].item
			get_parent().call_deferred("add_child", drop)
			drop.global_position = global_position
			drop.velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.5, -0.5)).normalized() * randf_range(20, 50)
	pass
