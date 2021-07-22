extends RigidBody2D


func _on_Bullet_body_entered(body):
	if !body.is_in_group("enemy"):
		var explosion_instance = Global.explosionPlayer.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
