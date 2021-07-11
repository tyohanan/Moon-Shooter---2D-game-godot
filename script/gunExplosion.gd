extends AnimatedSprite

func _ready():
	frame = 0
	playing = true

func _on_gunExplosion_animation_finished():
	queue_free()

func _on_DeathExplosion_animation_finished():
	queue_free()
