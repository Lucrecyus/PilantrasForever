extends KinematicBody2D

var movimento = Vector2()
var velocidade = 50
const FLOOR = Vector2(0, -1)
const PULO = -500
var gravidade = 20
var pulando = false
var atirando = false
const TIRO = preload("res://Cenas/TiroBoss.tscn")
var flip = false
var damage = 100
var shield = 100
var escudo = true
var dano = false
var danosoco = 6
var danochute = 10
var dano_socoforte = 15
var danotiro = 40
var danogranada = 60
var danobazzoka = 90

func _physics_process(_delta):
	if flip == false:
		$Position2D.position.x = 36
	else:
		$Position2D.position.x = -36
	
	movimento.y += gravidade
	movimento = move_and_slide(movimento, FLOOR)
	
	if damage <= 0:
		die()
	if shield <= 0:
		escudo = false
	if dano == true and shield > 0:
		get_node("AnimatedSprite").set_visible(true)
		barreira()
	elif dano == true and shield < 0:
		$Anim.play("dano")
		
	if movimento.y > 1000:
		die()
	
	
func _direita():
	movimento.x = velocidade
	
func _esquerda():
	movimento.x = - velocidade
func _idle():
	movimento.x = 0
	$Anim.play("Idle")

func _on_Direita_body_entered(_body):
	_direita()
	flip = false
	atirando = false
	$Anim.play("Walk")
	$soldier.flip_h = false
	$Jump.start()
	$Shot.start()
	
func _on_Esquerda_body_entered(_body):
	_esquerda()
	flip = true
	atirando = false
	$Anim.play("Walk")
	$soldier.flip_h = true
	$Jump.start()
	$Shot.start()
	
func _jump():
	pulando = true
	movimento.y = PULO
	$Anim.play("Jump")
	$Floor.start()
	
func _shot():
	_idle()
	$Anim.play("Shot")
	if pulando == true:
		$Anim.play("Jump")
	var tiro = TIRO.instance()
	$TiroFX.play()
	if sign($Position2D.position.x) == 36:
		tiro.set_tiro_direction(1)
	else:
		tiro.set_tiro_direction(-1)
		get_parent().add_child(tiro)
		tiro.position = $Position2D.global_position
	if $soldier.flip_h == false:
		tiro.set_tiro_direction(1)
		tiro.position = $Position2D.global_position

func _on_Jump_timeout():
	_jump()
	
func _on_Shot_timeout():
	atirando = true
	_shot()

func _on_Floor_timeout():
	pulando = false

func _on_Direita_body_exited(_body):
	_idle()
	if pulando == true:
		$Anim.play("Jump")

func _on_Esquerda_body_exited(_body):
	_idle()
	if pulando == true:
		$Anim.play("Jump")
#----------------------------- DANOS ----------------------------
func soco():
	dano = true
	if dano == true and escudo == false:
		$ResetDano.start()
		damage -= danosoco
		get_node("HP").value = int(damage)
	else:
		$ResetDano.start()
		shield -= danosoco
		get_node("Shield").value = int(shield)
func socoforte():
	dano = true
	if dano == true and escudo == false:
		$ResetDano.start()
		damage -= dano_socoforte
		get_node("HP").value = int(damage)
	else:
		$ResetDano.start()
		shield -= dano_socoforte
		get_node("Shield").value = int(shield)
func chute():
	dano = true
	if dano == true and escudo == false:
		movimento = Vector2(0,-200)	
		$ResetDano.start()
		damage -= danochute
		get_node("HP").value = int(damage)
	else:
		movimento = Vector2(0,-200)	
		$ResetDano.start()
		shield -= danochute
		get_node("Shield").value = int(shield)
		
func tiro():
	dano = true
	if dano == true and escudo == false:
		$Anim.play("dano")
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danotiro
		get_node("HP").value = int(damage)
	else:
		$ResetDano.start()
		barreira()

func granada():
	dano = true
	if dano == true and escudo == false:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danogranada
		get_node("HP").value = int(damage)
	else:
		movimento = Vector2(0,0)
		$ResetDano.start()
		shield -= danogranada
		get_node("Shield").value = int(shield)

func bazzoka():
	dano = true
	if dano == true and escudo == false:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danotiro
		get_node("HP").value = int(damage)
	else:
		movimento = Vector2(0,0)
		$ResetDano.start()
		shield -= danotiro
		get_node("Shield").value = int(shield)
		
func boombazuka():
	dano = true
	if dano == true and escudo == false:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		get_node("HP").value = int(damage)
	else:
		movimento = Vector2(0,0)
		$ResetDano.start()
		shield -= danobazzoka
		get_node("Shield").value = int(shield)
		
func bullet():
	dano = true
	if dano == true and escudo == false:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		get_node("HP").value = int(damage)
	else:
		movimento = Vector2(0,0)
		$ResetDano.start()
		shield -= danobazzoka
		get_node("Shield").value = int(shield)

func _on_ResetDano_timeout():
	dano = false
	get_node("AnimatedSprite").set_visible(false)
	_idle()
func barreira():
	$AnimatedSprite.play("barreira")
#----------------------MORRER------------------
func die():
	$Shot.stop()
	$Anim.play("Death")
	$colisor.disabled = true
	gravidade = 0
	movimento.y = 0
	
#--------OUTROS--------
func elevador():
	pass
func saiuelevador():
	pass


func _on_Dash_to_right_area_entered(_area):
	movimento.x = 10


func _on_Dash_to_left_area_entered(_area):
	movimento.x = -10
