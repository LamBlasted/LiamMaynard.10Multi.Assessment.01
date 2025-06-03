class_name State_Death extends State

@export var death_audio : AudioStream
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"



## What happens when we initialize this state?
func init() -> void:
	pass


## What happens when the player enters this State?
func enter() -> void:
	print("ENTERED DEATH STATE")
	player.animation_player.play("death")
	audio.stream = death_audio
	audio.play()
	PlayerHud.show_game_over_screen()
	pass


## What happens when the player exits this State?
func exit() -> void:
	pass


## What happens during the _process update in this State?
func process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return null


## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> State:
	return null




## What happens with input events in this State?
func handle_input( _event: InputEvent ) -> State:
	return null
