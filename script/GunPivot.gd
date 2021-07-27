extends Position2D

var can_fire = true
var enemy = null

export var speed = 100
export var bullet_speed = 1000
export var fire_rate = 0.2

onready var GunPoint = $Gun/GunPoint
onready var GunSprite = $Gun
onready var EnemyAreaDetection = $enemyDetection 

func _process(_delta):
	#mengecek apakah ada enemy di sekitar player kemudian rotasi
	if enemy != null:
		look_at(enemy.global_position)
		
	#program menembak enemynya
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = Global.bulletPlayer.instance()
		var gunSmoke = Global.gunSmoke.instance()
		
		gunSmoke.position = GunPoint.get_global_position()
		bullet_instance.position = GunPoint.get_global_position()
		
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	
		get_tree().get_root().add_child(bullet_instance)
		get_tree().get_root().add_child(gunSmoke)
		
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		
	#memanggil fungsi quadrant rotasi senjata
	checking_quadrant()
	
	#checking how much body overlapping in the area
	var bodies = EnemyAreaDetection.get_overlapping_bodies()


#mengecek gun sekarang masuk quadrant berapa kemudian diputar sesuai quadrant yg dimiliki
#enum{
#	Q1,
#	Q2,
#	Q3,
#	Q4
#}
#var quadrant = Q1
#func checking_quadrant():
#	match quadrant:
#		Q1:
#			GunSprite.flip_v = false
#		Q2:
#			GunSprite.flip_v = true
#		Q3:
#			GunSprite.flip_v  = true
#		Q4:
#			GunSprite.flip_v = false		
#
#	if enemy != null:
#		if rotation_degrees > 0  and rotation_degrees < 90:
#			quadrant = Q1
#		elif rotation_degrees > 90 and rotation_degrees < 180:
#			quadrant = Q2
#		elif rotation_degrees > 180 and rotation_degrees < 270:
#			quadrant = Q3
#		elif rotation_degrees > 270 and rotation_degrees < 360:
#			quadrant = Q4
#		elif rotation_degrees < 0 and rotation_degrees > -90:
#			quadrant = Q4
#		elif rotation_degrees < -90 and rotation_degrees > -180:
#			quadrant = Q3
#		elif rotation_degrees < -180 and rotation_degrees > -270:
#			quadrant = Q2
#		elif rotation_degrees < -270 and rotation_degrees > -360:
#			quadrant = Q1

func checking_quadrant():
#	print (sin(rotation_degrees/180)
	if enemy != null:
		var position_enemy = (enemy.global_position.x - global_position.x)
		print (position_enemy)
		if position_enemy > 0 :
			GunSprite.flip_v = false
		elif position_enemy < 0:
			GunSprite.flip_v = true

	#mengeflip gunsprite waktu player berjalan ke kiri atau ke kanan
	elif enemy == null:
		if Input.is_action_pressed("ui_left"):
			rotation_degrees = 180
			GunSprite.flip_v = true

		elif Input.is_action_pressed("ui_right"):
			rotation_degrees = 0
			GunSprite.flip_v = false
#	else :
##		quadrant = Q1
#		rotation_degrees = 0
	
	#mengeflip gunsprite waktu player berjalan ke kiri atau ke kanan
#	if Input.is_action_just_pressed("ui_left") && enemy == null:
#		rotation_degrees = 180
#		quadrant = Q3
#
#	elif Input.is_action_just_pressed("ui_right") && enemy == null:
#		rotation_degrees = 0
#		quadrant = Q1

func _on_enemyDetection_body_entered(body):
	enemy = body

func _on_enemyDetection_body_exited(_body):
	enemy = null
