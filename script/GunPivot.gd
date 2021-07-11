extends Position2D

var can_fire = true
var enemy = null

export var speed = 100
export var bullet_speed = 1000
export var fire_rate = 0.2

onready var GunPoint = $Gun/GunPoint
onready var GunSprite = $Gun

func _process(_delta):
	#mengecek apakah ada enemy di sekitar player kemudian rotasi
	if enemy != null:
		look_at(enemy.global_position)
	
	#program menembak enemynya
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = Global.bullet.instance()
		var gunExplosion = Global.gunExplosion.instance()
		
		gunExplosion.position = GunPoint.get_global_position()
		bullet_instance.position = GunPoint.get_global_position()
		
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		
		get_tree().get_root().add_child(bullet_instance)
		get_tree().get_root().add_child(gunExplosion)
		
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
	#mengeflip gunsprite waktu player berjalan ke kiri atau ke kanan
	if Input.is_action_just_pressed("ui_left") && enemy == null:
		rotation_degrees = 180
	elif Input.is_action_just_pressed("ui_right") && enemy == null:
		rotation_degrees = 0
		

	
func _on_enemyDetection_body_entered(body):
	enemy = body

func _on_enemyDetection_body_exited(_body):
	enemy = null
