extends Area2D

export (bool) var show_hit = true

var invincible = false setget set_invincible

onready var timer = $InvicibilityTimer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if (invincible == true):
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")


func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)
	

func _on_Hurtbox_invincibility_ended():
	monitorable = true


func _on_InvicibilityTimer_timeout():
	self.invincible = false
