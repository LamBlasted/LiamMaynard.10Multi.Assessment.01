class_name State_Attack extends State 

var attacking : bool = false 

#Export Values
@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

#Node References
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio : AudioStreamPlayer = $"../../Audio/AudioStreamPlayer"

#State References
@onready var idle : State = $"../Idle"
@onready var run: State = $"../Run"
@onready var hurt_box: HurtBox = %AttackHurtbox

# What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect( EndAttack )
	attacking = true
	
	attack_anim.play("attack_" + player.AnimDirection())
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.8, 1.2)
	
	await get_tree().create_timer( 0.15 ).timeout
	hurt_box.monitoring = true
	audio.play()
	pass

# What happens when the player exists this State?
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	hurt_box.monitoring = false 
	pass 

# What happens in the _physics_process update in this State?
func Process( _delta: float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle 
		else: 
			return run
	return null

# What happens with the input event in this State?
func HandleInput( _event: InputEvent ) -> State:
	return null 

func EndAttack( _newAnimName : String ) -> void:
	attacking = false 
