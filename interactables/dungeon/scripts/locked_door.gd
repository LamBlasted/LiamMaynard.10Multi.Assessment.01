class_name LockedDoor extends Node2D

@export var key_item : ItemData 
@export var locked_audio : AudioStream 
@export var open_audio : AudioStream

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var interact_area: Area2D = $"."
@onready var is_open_data: PersistentDataHandler = $"../PersistentDataHandler"



var is_open : bool = false 
