class_name EnemyStateStun extends EnemyState


@export var anim_name : String = "stun"
@export var decelerate_speed : float = 10.0
@onready var effect_animation_player: AnimationPlayer = $"../../EffectAnimationPlayer"
@onready var hurt_box: HurtBox = $"../../hurtbox"
@export var knockback_speed : float = 200.0


# AI Export Category
@export_category("AI")
@export var next_state : EnemyState

var _damage_position : Vector2
var _direction : Vector2 
var _animation_finished : bool

# What happens when we initialize this state?
func init() -> void:
	enemy.enemy_damaged.connect( _on_enemy_damaged )
	pass

# What happens when the player enters this State?
func Enter() -> void:
	hurt_box.monitoring = false 
	effect_animation_player.play("damaged")
	enemy.invulnerable = true
	_animation_finished = false 
	
	_direction = enemy.global_position.direction_to( _damage_position )
	
	enemy.SetDirection( _direction )
	enemy.velocity = _direction * -knockback_speed 
	
	enemy.UpdateAnimation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass

# What happens when the player exists this State?
func Exit() -> void:
	await get_tree().create_timer(.4).timeout
	hurt_box.monitoring = true
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> EnemyState:
	if _animation_finished == true: 
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null


func Physics( _delta : float ) -> EnemyState:
	return null


func _on_enemy_damaged(  hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState( self )

func _on_animation_finished( _a : String ) -> void:
	_animation_finished = true
