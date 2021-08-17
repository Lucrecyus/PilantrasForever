extends KinematicBody2D

const SPEED = 500
var velocidade = Vector2()
var direction = 1

func _ready():
	pass

func set_bazzoka_direction(dir):
	direction = dir
	if direction <= -1:
		$Sprite.flip_h = true
	
func _physics_process(delta):
	velocidade.x = SPEED * delta * direction
	translate(velocidade)

func _on_Bazzoka_body_entered(body):
	$AnimatedSprite.play("boom")
	$Boom.play()
	get_node("Light2D").set_visible(true)
	velocidade.x = 0
	body.bazzoka()
	

func _on_AnimatedSprite_animation_finished():
	queue_free()
	
func elevador():
	pass
func saiuelevador():
	pass
func armadilha():
	queue_free()

func _on_BoomBazuca_body_entered(body):

	body.boombazuka()

func _on_AnimatedSprite_frame_changed():
	$BoomBazuca/CollisionShape2D.disabled = false

func tiroboss():
	$AnimatedSprite.play("boom")
	$Boom.play()
	get_node("Light2D").set_visible(true)
	velocidade.x = 0
