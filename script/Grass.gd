extends Node2D

func grass_destroyed_effect():
	var grassDestroyed = Global.GrassDestroyed.instance()
	get_parent().add_child(grassDestroyed)
	grassDestroyed.global_position = global_position

func _on_Grass_body_entered(_body):
	grass_destroyed_effect()
	queue_free()
