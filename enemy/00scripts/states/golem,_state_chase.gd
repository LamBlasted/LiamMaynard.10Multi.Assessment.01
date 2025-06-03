class_name GolemStateChase extends EnemyStateChase 

@export var spawn_delay: float = 5.0
var spawn_timer: Timer
var spawn_timer_started := false
var has_triggered_spawn := false

func Enter() -> void:
	super.Enter()  
	has_triggered_spawn = false

	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_delay
	spawn_timer.one_shot = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	enemy.add_child(spawn_timer)
	spawn_timer.start()
	spawn_timer_started = true

func Exit() -> void:
	super.Exit()  



func _on_spawn_timer_timeout():
	has_triggered_spawn = true

func Process(_delta: float) -> EnemyState:
	if has_triggered_spawn:
		return $"../Spawn" 
	return super.Process(_delta)
