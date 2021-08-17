extends Area2D

var player = null
var move = Vector2.ZERO
var speed = 10
var look_vec = Vector2.ZERO

func _ready():
	
	look_vec = player.position - global_position
func _physics_process(delta):
	move = Vector2.ZERO
	$Anim.play("tiro")
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move
	
	

func _on_TiroBoss_drone_body_entered(body):
	body.tiro_bossDrone()
	queue_free()

