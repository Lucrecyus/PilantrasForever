extends Area2D

const SPEED = 1000
var velocidade = Vector2()
var direction = 1


func set_laser_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocidade.x = SPEED * delta * direction
	translate(velocidade)
	$Anim.play("run")

	


func _on_Laser_ghost_body_entered(body):
	body.laserghost()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func tiro():
	pass
func elevador():
	pass
func saiuelevador():
	pass
func tirometranca():
	pass
func tirodrone():
	pass	
	
func tiroboss():
	pass
	
func granada():
	pass
func bazzoka():
	pass
func socoboss():
	pass
func tiro_bossDrone():
	pass
	
func boombazuka():
	pass
func armadilha():
	pass
	
