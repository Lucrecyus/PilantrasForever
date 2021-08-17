extends Area2D

var player = null
var move = Vector2.ZERO
var speed = 5
var look_vec = Vector2.ZERO

func _ready():
	
	look_vec = player.position - global_position
func _physics_process(delta):
	move = Vector2.ZERO
	$Anim.play("Tirodrone")
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move
	
	




func _on_Tirodrone_body_entered(body):
	body.tirodrone()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func armadilha():
	queue_free()
