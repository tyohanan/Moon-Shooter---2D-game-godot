extends Node2D

func _ready():
	var overlay = Global.debug_overlay.instance()
	overlay.add_stat("Player position", $Ysort/Player, "position", false)
	overlay.add_stat("player gun rotation", $Ysort/Player/GunPivot, "rotation_degrees", false)
	add_child(overlay)
