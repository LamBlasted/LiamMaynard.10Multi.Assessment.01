extends CanvasLayer

@onready var boss = preload("res://enemy/golem/golem.tscn")
@onready var health_bar = $Control/ProgressBar

func _ready():
	hide()

func connect_to_boss(b: Enemy) -> void:
	boss = b
	health_bar.max_value = boss.hp
	health_bar.value = boss.hp
	show()
	boss.enemy_damaged.connect(_on_boss_damaged)
	boss.enemy_destroyed.connect(_on_boss_destroyed)

func _on_boss_damaged(_hurtbox):
	health_bar.value = boss.hp

func _on_boss_destroyed(_hurtbox):
	hide()
