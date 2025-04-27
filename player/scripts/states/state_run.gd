class_name State_Run extends State 

@export var move_speed : float = 100.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"

# What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("run")
	player.velocity = Vector2.ZERO

# What happens when the player exists this State?
func Exit() -> void:
	pass 

# What happens in the _process update in this State?
func Process( _delta: float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("run")
	
	return null

# What happens in the _physics_process update in this State?
func Physics( _delta : float ) -> State: 
	return null 

# What happens with the input event in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null 
