extends Area2D

const SPEED = 600
var velocidade = Vector2()
var direction = 1


func set_tiro_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocidade.x = SPEED * delta * direction
	translate(velocidade)
	$Anim.play("tiroBoss")
	

func _on_TiroBoss_body_entered(body):
	body.tiroboss()
	queue_free()
	
func granada():
	pass
	
func bazzoka():
	pass

func armadilha():
	queue_free()
