extends Area2D


@export var boss_node: Enemy 

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		BossBar.connect_to_boss(boss_node)



func _on_body_exited(body: Node2D) -> void:
	queue_free()
