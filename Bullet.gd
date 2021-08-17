extends StaticBody2D

var direction = 1
var velocidade = 15
var cair = -15
	
func _process(_delta):
	
	$".".position.x += velocidade * direction
	$".".position.y -= cair
	

func set_bullet_direction(dir):

	direction = dir 

func danotatu():
	pass
func elevador():
	queue_free()
func saiuelevador():
	pass


func _on_colisor_body_entered(body):
	body.bullet()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
