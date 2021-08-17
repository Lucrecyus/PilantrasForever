extends KinematicBody2D

var movimento = Vector2()
export var velocidade = 120
export var gravidade = 20
const PULO = - 500
const FLOOR_NORMAL = Vector2(0, -1)
var flip = false
var atack = false
export var damage = 100
const DANOQUEDA = 10
export var danosoldier = 8
export var danosoco = 2
export var danosocoforte = 4
export var danochute = 6
export var danogranada = 50
export var danobazuka = 100
var morreu = false
var atirar = false
const TIRO = preload("res://Cenas/Tiro.tscn")
const GRANADA = preload("res://Cenas/Granada.tscn")
const BAZZOKA = preload("res://Cenas/Bazzoka.tscn")
export var balas = 15
export var granadas = 0
export var missel = 0
var vida_maxima = 100
var vida_media = 50
var noelevador = false
var dano = false
var idle = true
var run = false
var agachado = false
var ataqueUp = false
var change_weapon = 1

func _ready():
	$Anim.play("Idle_L")

	
func _physics_process(delta):
	
	if morreu == false:
		
		movimento.x = velocidade * delta
		
		movimento.y += gravidade
			
		if flip == true:
			$Tiro2.position.x = -35
			$Arremeco.position.x = -19
			$tiromissel.position.x = -45
		if flip == false:
			$Tiro2.position.x = 30
			$Arremeco.position.x = 19
			$tiromissel.position.x = 45
		
		if Input.is_action_pressed("direita") and atack == false and atirar == false and !dano:
			idle = false
			run = true
			direita()
			
		elif Input.is_action_pressed("esquerda") and atack == false and atirar == false and !dano:
			idle = false
			run = true
			esquerda()
			
		elif Input.is_action_pressed("baixo") and atack == false and atirar == false and !dano:
			idle = false
			agachar()
		
		else:
			$CollisionShape2D.disabled = false
			$DashD/CollisionShape2D.disabled = false
			$DashE/CollisionShape2D.disabled = false
			$Agachado.disabled = true
			idle = true
			run = false
			agachado = false
			parado()
		
				
		if Input.is_action_just_pressed("socofraco") and !agachado and !ataqueUp:
			ataque()
		
		if Input.is_action_just_pressed("socoforte") and !agachado:
			ataque1()
			
		if Input.is_action_just_pressed("chute") and !agachado and !ataqueUp:
			ataque2()
			
		if flip == true:
			$AttackArea/CollisionShape2D.position.x = -21
			$AttackArea3/CollisionShape2D.position.x = -21
			$AttackArea4/CollisionShape2D.position.x = -30
		else:
			$AttackArea/CollisionShape2D.position.x = 19
			$AttackArea3/CollisionShape2D.position.x = 19
			$AttackArea4/CollisionShape2D.position.x = 25
		
		if Input.is_action_just_pressed("atirar") and atirar == false and balas > 0 and change_weapon == 1:
			$TiroFx.play()
			shoot()
			
		#Contagem de balas
		$CanvasLayer2/Label.set_text(String(balas))
		
		if Input.is_action_just_pressed("atirar") and atirar == false and granadas > 0 and change_weapon == 0:
			jogargranada()
		$CanvasLayer2/granadas.set_text(String(granadas))
		
		if Input.is_action_just_pressed("atirar") and atirar == false and missel > 0 and change_weapon == 2:

			tirobazzoka()
		$CanvasLayer2/misseis.set_text(String(missel))
			
		
		if Input.is_action_just_pressed("atirar") and balas == 0 and change_weapon == 1:
			$clicFX.play()
		if Input.is_action_just_pressed("selecao") and change_weapon == 1:
			get_node("CanvasLayer2/selected").set_visible(false)
			get_node("CanvasLayer2/selected2").set_visible(true)
			get_node("CanvasLayer2/selected3").set_visible(false)
			change_weapon -= 1
			
		elif change_weapon == 0 and Input.is_action_just_pressed("selecao"):
			change_weapon += 2
			get_node("CanvasLayer2/selected").set_visible(false)
			get_node("CanvasLayer2/selected2").set_visible(false)
			get_node("CanvasLayer2/selected3").set_visible(true)
		elif change_weapon == 2 and Input.is_action_just_pressed("selecao"):
			get_node("CanvasLayer2/selected").set_visible(true)
			get_node("CanvasLayer2/selected2").set_visible(false)
			get_node("CanvasLayer2/selected3").set_visible(false)
			change_weapon -= 1
		
		if is_on_floor():
			if Input.is_action_just_pressed("pular") and !agachado:
				pular()
		else:
			if atack == false and noelevador == false and atirar == false and morreu == false and !dano:
				$Anim.play("Jump_R")
				if flip == true:
					$Anim.play("Jump_L")
		
		if movimento.y > 900:
			danogeral()
					
		movimento = move_and_slide(movimento, FLOOR_NORMAL)
		
		if damage < 1:
			morrer()
			morte()
		
func morte():
	$morrerFX.play()
	$Timer2.start()
				
func _on_Timer2_timeout():
	var _iniciar
	_iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
		
func direita():
	flip = false
	movimento.x = velocidade
	$Anim.play("Walk_R")
func esquerda():
	flip = true
	movimento.x = - velocidade
	$Anim.play("Walk_L")
	
func morrer():
	morreu = true
	if morreu == true:
		$Anim.play("Die")
		movimento = Vector2(0, 0)
		$CollisionShape2D.disabled = true
			
func _on_ResetAttack_timeout():
	atack = false
	dano = false
	parado()
	$AttackArea/CollisionShape2D.disabled = true
	$AttackArea4/CollisionShape2D.disabled = true
	
func _on_ataque1_timeout():
	atack = false
	dano = false
	ataqueUp = false
	parado()
	$AttackArea3/CollisionShape2D.disabled = true

		
func cartucho():
	balas += 15
	$clicFX.play()
	
func misseis():
	missel += 5
	
func getgranada():
	granadas += 5
	$socoforteFX.play()

func jogargranada():
	if is_on_floor():
		movimento.x = 0
	granadas -= 1
	$socoforteFX.play()
	var granada = GRANADA.instance()
	get_parent().add_child(granada)
	granada.position = $Arremeco.global_position
	if sign($Arremeco.position.x) >= 1:
		granada.set_granada_direction(1)
	else:
		granada.set_granada_direction(-1)
	$ShootReset3.start()
	atirar = true
	$Anim.play("arremeco")
	if flip == true:
		$Anim.play("arremeco_L")

func _on_ShootReset3_timeout():
	atirar = false
	idle = true
	get_node("Light2D").set_visible(false)

func _on_MisselReset_timeout():
	atirar = false
	idle = true
	get_node("Light2D").set_visible(false)

func vida():
	$lifeFX.play()
	damage = vida_maxima
	get_node("CanvasLayer2/HPplayer").value = int(damage)
func vidamedia():
	$lifeFX.play()
	if damage < 100:
		damage = damage + vida_media
	get_node("CanvasLayer2/HPplayer").value = int(damage)
	if damage > 100:
		damage = 100
	
func elevador():
	noelevador = true


func saiuelevador():
	noelevador = false


func gatecontrol():
	pass
	

func _on_AttackArea_body_entered(body):
	$punchfracoFX.play()
	body.soco()


func _on_AttackArea3_body_entered(body):
	$punchforteFX.play()
	body.socoforte()


func _on_AttackArea4_body_entered(body):
	$kickFX.play()
	body.chute()

func soco():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danosoco
		$punchfracoFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)
func socoforte():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danosocoforte
		$punchforteFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)

func chute():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danochute
		$kickFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)
	
func granada():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)

func boombazuka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danobazuka
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)

func bazzoka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)

func tiro():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danosoldier
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset2.start()
		get_node("CanvasLayer2/HPplayer").value = int(damage)

func _on_DanoReset2_timeout():
	dano = false
	parado()
	if dano == false and idle == true:
		velocidade = 120


func parado():
	movimento.x = 0
	idle = true
	if flip == false and movimento.x == 0 and atack == false and atirar == false and idle == true and dano == false and morreu == false:
		$Anim.play("Idle_R")
		
	elif flip == true and movimento.x == 0 and atack == false and atirar == false and idle == true and dano == false and morreu == false:
		$Anim.play("Idle_L")
	
	
func ataque():
	atack = true
	idle = false
	$ResetAttack.start()
	if atack == true and idle == false:
		$socofracoFX.play()
		$Anim.play("Attack_R")
		$AttackArea/CollisionShape2D.disabled = false
		if flip == true:
			$Anim.play("Attack_L")
			$AttackArea/CollisionShape2D.disabled = false
func ataque1():
	atack = true
	idle = false
	ataqueUp = true
	$socoforteFX.play()
	$ataque1.start()
	if atack == true and idle == false:
		$Anim.play("Attack1_R")
		$AttackArea3/CollisionShape2D.disabled = false
		if flip == true:
			$Anim.play("Attack1_L")
			$AttackArea3/CollisionShape2D.disabled = false
			
func ataque2():
	atack = true
	idle = false
	$chuteFX.play()
	$ResetAttack.start()
	if atack == true and idle == false:
		$Anim.play("Kick_R")
		$AttackArea4/CollisionShape2D.disabled = false
		if flip == true:
			$Anim.play("Kick_L")
			$AttackArea4/CollisionShape2D.disabled = false

			
func shoot():
	if is_on_floor():
		get_node("Light2D").set_visible(true)
	
		movimento.x = 0
	balas -= 1
	var tiro = TIRO.instance()
	if sign($Tiro2.position.x) >= 1:
		tiro.set_tiro_direction(1)
	else:
		tiro.set_tiro_direction(-1)
	get_parent().add_child(tiro)
	tiro.position = $Tiro2.global_position
	$ShootReset3.start()
	atirar = true
	$Anim.play("Shoot_R")
	if flip == true:
		$Anim.play("Shoot_L")

func tirobazzoka():
	$bazuca.play()
	movimento.x = 0
	missel -= 1
	var bazzoka = BAZZOKA.instance()
	if sign($tiromissel.position.x) >= 1:
		bazzoka.set_bazzoka_direction(1)
	else:
		bazzoka.set_bazzoka_direction(-1)
	get_parent().add_child(bazzoka)
	bazzoka.position = $tiromissel.global_position
	$MisselReset.start()
	atirar = true
	$Anim.play("bazoka_R")
	if flip == true:
		$Anim.play("bazoka_L")
	
	
			
func danogeral():
	dano = true
	if dano == true:
		$DanoReset2.start()
		$danoFX.play()
		$Anim.play("Dano")
		damage -= DANOQUEDA
		get_node("CanvasLayer2/HPplayer").value = int(damage)
		

# warning-ignore:unused_argument
func _on_Pulo2_body_entered(body):
	if dano == false:
		pular()


func pular():
	movimento.y = PULO
	$PuloFX.play()

func agachar():
	agachado = true
	movimento.x = 0
	$CollisionShape2D.disabled = true
	$DashD/CollisionShape2D.disabled = true
	$DashE/CollisionShape2D.disabled = true
	$Agachado.disabled = false
	$Anim.play("agachar")
	if flip == true:
		movimento.x = 0
		$CollisionShape2D.disabled = true
		$DashD/CollisionShape2D.disabled = true
		$DashE/CollisionShape2D.disabled = true
		$Agachado.disabled = false
		$Anim.play("agachar_L")
	

func _on_DashD_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento = Vector2(100,0)
	$Anim.play("Dano")


func _on_DashE_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento = Vector2(-100,0)
	$Anim.play("Dano")
# 
	


