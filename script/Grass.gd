extends Node2D


func grass_destroyed_effect():
	var grassDestroyed = Global.GrassDestroyed.instance()
	get_parent().add_child(grassDestroyed)
	grassDestroyed.global_position = global_position



func _on_Hurtbox_area_entered(_area):
	grass_destroyed_effect()
	queue_free()
