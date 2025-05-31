class_name ItemEffectHealOnPickup extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream

func on_pickup() -> void:
	PlayerManager.player.update_hp(heal_amount)
	PauseMenu.play_audio(audio)
