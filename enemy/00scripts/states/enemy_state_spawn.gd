class_name EnemyStateSpawn extends EnemyState

@export var anim_name: String = "spawn"
@export var spawn_scene: PackedScene
@export var spawn_count: int = 3
@export var spawn_radius: float = 64.0
@export var next_state: EnemyState

var _done_spawning := false

func init() -> void:
	pass

func Enter() -> void:
	enemy.velocity = Vector2.ZERO
	enemy.UpdateAnimation(anim_name)
	_done_spawning = false
	spawn_enemies()
	enemy.animation_player.animation_finished.connect(_on_animation_finished)

func Exit() -> void:
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)

func Process(_delta: float) -> EnemyState:
	if _done_spawning:
		return next_state
	return null

func Physics(_delta: float) -> EnemyState:
	return null

func spawn_enemies():
	if not spawn_scene:
		return
	for i in spawn_count:
		var enemy_instance = spawn_scene.instantiate()
		var offset = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
		enemy_instance.global_position = enemy.global_position + offset
		enemy.get_parent().add_child(enemy_instance)

func _on_animation_finished(_name: String) -> void:
	_done_spawning = true
