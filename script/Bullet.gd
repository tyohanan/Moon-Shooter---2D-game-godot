extends RigidBody2D

func _on_Bullet_body_entered(body):
	if !body.is_in_group("player"):
		var explosion_instance = Global.explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()

#close enough
