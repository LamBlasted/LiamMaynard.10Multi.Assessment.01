class_name State_Idle extends State 

@onready var run: State = $"../Run"


# What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

# What happens when the player exists this State?
func Exit() -> void:
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> State:
	if player.direction != Vector2.ZERO:
		return run
	player.velocity = Vector2.ZERO
	return null

# What happens with the input event in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null 
