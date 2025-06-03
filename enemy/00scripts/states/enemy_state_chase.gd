class_name EnemyStateChase extends EnemyState

@export var anim_name : String = "chase"
@export var chase_speed : float = 20.0
@export var turn_rate : float = 0.25

# AI Export Category
@export_category("AI")
@export var state_aggro_duration : float = 0.5
@export var next_state : EnemyState
@export var vission_area : VissionArea
@export var attack_area : HurtBox

var _timer : float = 0.0 
var _direction : Vector2 
var _can_see_player : bool = false 


# What happens when we initialize this state?
func init() -> void:
	if vission_area:
		vission_area.player_entered.connect( _on_player_enter )
		vission_area.player_exited.connect( _on_player_exit )
	pass

# What happens when the player enters this State?
func Enter() -> void:
	_timer = state_aggro_duration
	enemy.UpdateAnimation( anim_name )
	if attack_area: 
		attack_area.monitoring = true
	if vission_area and vission_area.get_overlapping_bodies().has(PlayerManager.player):
		_can_see_player = true 
	else:
		_can_see_player = false
	pass

# What happens when the player exists this State?
func Exit() -> void:
	if attack_area:
		attack_area.monitoring = false 
	_can_see_player = false 
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> EnemyState:
	var new_dir : Vector2 = enemy.global_position.direction_to( PlayerManager.player.global_position )
	_direction = lerp( _direction, new_dir, turn_rate )
	enemy.velocity = _direction * chase_speed 
	if enemy.SetDirection( _direction ):
		enemy.UpdateAnimation( anim_name )
	if _can_see_player == false:
		_timer -= _delta
		if _timer < 0:
			return next_state
	else: 
		_timer = state_aggro_duration
	return null

func Physics( _delta : float ) -> EnemyState:
	return null

func _on_player_enter() -> void:
	_can_see_player = true 
	if(
		state_machine.current_state is EnemyStateStun
		or state_machine.current_state is EnemyStateDestroy
	):
		return
	state_machine.ChangeState( self )
	pass

func _on_player_exit() -> void:
	_can_see_player = false 
	pass
