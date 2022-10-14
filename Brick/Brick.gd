extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(131,101,30)
	elif score >= 90:
		$ColorRect.color = Color8(198,176,126)
	elif score >= 80:
		$ColorRect.color = Color8(132,97,15)
	elif score >= 70:
		$ColorRect.color = Color8(239,200,109)
	elif score >= 60:
		$ColorRect.color = Color8(255,235,185)
	elif score >= 50:
		$ColorRect.color = Color8(57,42,8)
	elif score >= 40:
		$ColorRect.color = Color8(129,92,5)
	else:
		$ColorRect.color = Color8(255,248,229)
func _physics_process(_delta):
	if dying:
		queue_free()

func hit(_ball):
	var brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if brick_sound != null:
		brick_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
