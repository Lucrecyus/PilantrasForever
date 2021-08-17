extends Area2D

const SPEED = 800
var velocidade = Vector2()
var direction = 1


func set_tiro_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocidade.x = SPEED * delta * direction
	translate(velocidade)
	$balametranca.play("tiro")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_TiroMetranca_body_entered(body):
	body.tirometranca()
	queue_free()

func armadilha():
	queue_free()
