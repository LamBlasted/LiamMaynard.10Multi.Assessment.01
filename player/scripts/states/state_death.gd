class_name State_Death extends State

@export var death_audio : AudioStream
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer = $"../../Audio/AudioStreamPlayer"



## What happens when we initialize this state?
func Init() -> void:
	pass


## What happens when the player enters this State?
func Enter() -> void:
	player.animation_player.play("death")
	audio.stream = death_audio
	audio.play()
	PlayerHud.show_game_over_screen()
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return null


## What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null




## What happens with input events in this State?
func Handle_input( _event: InputEvent ) -> State:
	return null
