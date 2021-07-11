extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0
var type = ""

var velocity = Vector2(0,0)

func _ready():
	match type:
		"Heal":
			label.set_text("+" + str(amount))	
			label.set("custom_colors/font_color", Color("4cff60"))
		"Damage":
			label.set_text("-" + str(amount))
			label.set("custom_colors/font_color", Color("ff4c4c"))
	
	randomize()
	var side_movement = randi() % 81 - 20
	velocity = Vector2(side_movement, 30)
	tween.interpolate_property(self, 'scale', scale, Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', Vector2(1,1), Vector2(0.1, 0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()

func _process(delta):
	position -= velocity * delta

func _on_Tween_tween_all_completed():
	self.queue_free()
