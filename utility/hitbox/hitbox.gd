class_name HitBox extends Area2D

signal damaged(  hurt_box : HurtBox )

func _ready():
	pass 


func _process(_delta) :
	pass

#
func take_damage( hurt_box : HurtBox ) -> void: 
	print("Took Damage")
	damaged.emit( hurt_box )
