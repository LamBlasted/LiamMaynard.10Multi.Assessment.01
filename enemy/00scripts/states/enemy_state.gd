class_name EnemyState extends Node

# Stores a references to the enemy that this state belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine



# What happens when we initialize this state?
func init() -> void:
	pass

# What happens when the player enters this State?
func Enter() -> void:
	pass

# What happens when the player exists this State?
func Exit() -> void:
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> EnemyState:
	return null

func Physics( _delta : float ) -> EnemyState:
	return null
