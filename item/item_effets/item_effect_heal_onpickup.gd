class_name ItemEffectHealOnPickup extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream

func on_pickup() -> void:
	if PlayerManager.player:
		PlayerManager.player.update_hp(heal_amount)
	if audio and PauseMenu:
		PauseMenu.play_audio(audio)
