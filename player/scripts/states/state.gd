class_name State extends Node

# Stores a references to the player that this State belongs to 
static var player: Player
static var state_machine : PlayerStateMachine

func _ready() -> void:
	pass 


func init() -> void:
	pass



# What happens when the player enters this State?
func Enter() -> void:
	pass

# What happens when the player exists this State?
func Exit() -> void:
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> State:
	return null

func Physics( _delta : float ) -> State:
	return null

# What happens with the input event in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null 
