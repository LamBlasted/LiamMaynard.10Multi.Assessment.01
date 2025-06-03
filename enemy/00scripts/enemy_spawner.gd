class_name EnemySpawner extends Node2D

@export var enemy_scene: PackedScene
@export var max_spawn_count: int = 5
@export var spawn_interval: float = 2.0
@export var spawn_radius: float = 64.0

var spawned_enemies: Array = []

func _ready():
	start_spawning()

func start_spawning():
	spawn_enemy()
	if spawn_interval > 0:
		var timer = Timer.new()
		timer.wait_time = spawn_interval
		timer.autostart = true
		timer.one_shot = false
		timer.timeout.connect(_on_spawn_timer_timeout)
		add_child(timer)

func _on_spawn_timer_timeout():
	if spawned_enemies.size() < max_spawn_count:
		spawn_enemy()

func spawn_enemy():
	if not enemy_scene:
		return

	var enemy = enemy_scene.instantiate()
	var offset = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
	enemy.global_position = global_position + offset

	get_tree().get_root().add_child(enemy)  # or use get_parent() if you want to spawn within a level

	spawned_enemies.append(enemy)

	# Optional: remove from list on enemy death
	if enemy.has_signal("tree_exited"):
		enemy.tree_exited.connect(func(): spawned_enemies.erase(enemy))
