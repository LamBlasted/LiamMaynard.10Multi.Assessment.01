class_name Plant extends Node


func _ready():
	$hitbox.damaged.connect( take_damage )
	pass


func take_damage ( _hurt_box : HurtBox ) -> void: 
	queue_free()
	pass
