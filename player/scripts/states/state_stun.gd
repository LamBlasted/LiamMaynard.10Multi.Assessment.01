class_name State_Stun extends State 

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurt_box: HurtBox
var direction : Vector2 

var next_state : State = null

@onready var idle: State = $"../Idle"
@onready var death: State_Death = $"../Death"



func init() -> void:
	player.PlayerDamaged.connect( _PlayerDamaged )

# What happens when the player enters this State?
func Enter() -> void:
	player.animation_player.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurt_box.global_position )
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	
	player.UpdateAnimation("stun")
	player.make_invulnerable( invulnerable_duration )
	player.effect_animation_player.play("damaged")
	pass

# What happens when the player exists this State?
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass 

# What happens in the _process update in this State?
func Process( _delta: float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state

# What happens in the _physics_process update in this State?
func Physics( _delta : float ) -> State: 
	return null 

# What happens with the input event in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null 

func _PlayerDamaged( _hurt_box : HurtBox ) -> void:
	hurt_box = _hurt_box
	if state_machine.current_state != death:
		state_machine.ChangeState( self )
	pass


func _animation_finished( _a: String ) -> void: 
	next_state = idle
	if player.hp <= 0:
		next_state = death
