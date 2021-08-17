extends KinematicBody2D

const SPEED = 1000
var velocidade = Vector2()
var direction = 1

func _ready():
	pass

func set_tiro_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocidade.x = SPEED * delta * direction
	translate(velocidade)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Tiro_body_entered(body):
	$Anim.play("run")
	body.tiro()
	velocidade.x = 0

func _on_Anim_animation_finished():
	queue_free()

func tiroboss():
	queue_free()
func elevador():
	pass
func saiuelevador():
	pass
func danotatu():
	pass
func cartucho():
	pass
func armadilha():
	queue_free()
