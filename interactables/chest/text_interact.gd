extends Area2D

@onready var interact: Label = $"../Sprite2D/Interact"

func _on_body_entered(body: Node2D) -> void:
	interact.visible = true



func _on_body_exited(body: Node2D) -> void:
	interact.visible = false
