extends KinematicBody2D

#sistem nyawa ditambahin pake stats di luar gerakan kinematikbody2D
enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK
}

export var MAX_SPEED = 40
export var ACCELERATION = 200
export var FRICTION = 1200
export var wanders = true

var state = IDLE
var player = null
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var wander_position

onready var initial_position = global_position
onready var playerSprite = $playerSprite
onready var wanderTimer = $WanderTimer
onready var animationTree = $AnimationTree
onready var statsHealth = $StatsHealth
onready var hurtbox = $Hurtbox
onready var hpbar = $HpBar
onready var tweenHpbar = $HpBar/Tween

onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

	
func _physics_process(delta):
	match state:
		IDLE:
			if global_position.distance_to(initial_position) > 50:
				direction = global_position.direction_to(initial_position) * 50
				direction = move_and_slide(direction)
			elif direction != Vector2.ZERO:
				direction = direction.move_toward(Vector2.ZERO, 100 * delta)
				direction = move_and_slide(direction)
			if wanders:
				if wanderTimer.time_left == 0:
					wanderTimer.start()
		
		WANDER:
			wander_position = initial_position + Vector2(rand_range(-1, 1), rand_range(-1, 1))
			direction = global_position.direction_to(wander_position) * 50
			direction = move_and_slide(direction)
			state = IDLE
		
		CHASE:
			direction = global_position.direction_to(player.global_position)
			velocity = velocity.move_toward(direction*MAX_SPEED, ACCELERATION*delta)
			velocity = move_and_slide(velocity)
			
		ATTACK:
			direction = direction.move_toward(Vector2.ZERO, 100 * delta)
			direction = move_and_slide(direction)
		
			
	#function to play animation state in enemy
	var animdirect = direction.normalized()
	animationTree.set("parameters/Idle/blend_position", animdirect)
	animationTree.set("parameters/Run/blend_position", animdirect)		
	if direction != Vector2.ZERO:
		animationState.travel("Run")
	else :
		animationState.travel("Idle")
		
	
#function to keep track wander time
func _on_WanderTimer_timeout():
	if state != CHASE:
		state = WANDER

func _on_PlayerDetectionZone_body_entered(body):
	state = CHASE
	player = body

func _on_PlayerDetectionZone_body_exited(_body):
	state = IDLE
	player = null


#jika stats health sudah nol maka hapus player
func _on_StatsHealth_no_health():
	queue_free()
	var death = Global.enemyDeath.instance()
	get_parent().add_child(death)
	death.global_position = global_position
	

#jika damage terkena pada musuh
func _on_Hurtbox_area_entered(area):
	statsHealth.health -= area.damage
	hurtbox.start_invincibility(0.4)
	
	#menginstantiate floating text
	var text = Global.floatingText.instance()
	text.amount = area.damage
	text.type = "Damage"
	get_parent().add_child(text)
	text.global_position = area.global_position

	#calling healthbar function
	healthbar()
		
func healthbar():
	var percentage = int(float(statsHealth.health)/statsHealth.max_health*100)
	tweenHpbar.interpolate_property(hpbar, "value", hpbar.value, percentage, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tweenHpbar.start()
	if percentage > 80:
		hpbar.tint_progress = "02cc00"
	elif percentage <= 80 and percentage >30:
		hpbar.tint_progress = "cc6e00"
	else : 
		hpbar.tint_progress = "cc0000"

func _on_GunFiringZone_body_entered(_body):
	state = ATTACK

func _on_GunFiringZone_body_exited(_body):
	state = CHASE
