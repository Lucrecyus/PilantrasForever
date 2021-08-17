extends KinematicBody2D

var gravidade = 00.28
var movimento = Vector2()
var velocidade = 400
var direction = 1
var pegaraltura = - 6
var alturaMax
var altura_inicial


func _ready():
	$sumir.start()

func set_granada_direction(dir):
	direction = dir
	
func _physics_process(delta):
	
	altura_inicial = $".".global_position.y
	alturaMax = altura_inicial - 100
	movimento.x = velocidade * delta * direction
	
	if altura_inicial:
		movimento.y = pegaraltura

	if alturaMax >= alturaMax:
		
		pegaraltura += gravidade
	
	var _collision = move_and_collide(movimento)

func _on_Area2D_body_entered(_body):
	$sumir.start()
	
func _on_Boom_body_entered(body):
	
	body.granada()
func danotatu():
	pass
func elevador():
	pass
func saiuelevador():
	pass	
func armadilha():
	queue_free()

func _on_sumir_timeout():
	$Boom/boom.disabled = false
	$Anim.play("explodir")
	$boom.play()
	get_node("Light2D").set_visible(true)
	$AnimatedSprite.play("boom")
	
func tiroboss():
	pass
