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
export var danoboss = 15
export var soco_boss = 10
export var laserboss = 15
export var danosoldier = 5
export var danocybertatu = 20
export var danoatirador = 15
export var danodrone = 6
export var danogranada = 50
export var danobazuka = 100
var morreu = false
var atirar = false
const TIRO = preload("res://Cenas/Tiro.tscn")
const GRANADA = preload("res://Cenas/Granada.tscn")
const BAZZOKA = preload("res://Cenas/Bazzoka.tscn")
const BULLET = preload("res://Cenas/Bullet.tscn")
const SHIELD = preload("res://Cenas/Shield_player.tscn")
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
var nodrone = false
export var escudo = 0

func _ready():

	pass
	
func _physics_process(delta):
	
	if morreu == false:
		
		movimento.x = velocidade * delta
		
		movimento.y += gravidade
		
		
		if flip == true:
			$Tiro.position.x = -35
			$Arremeco.position.x = -19
			$tiromissel.position.x = -45
			$Tiro_drone.position.x = -68
		if flip == false:
			$Tiro.position.x = 30
			$Arremeco.position.x = 19
			$tiromissel.position.x = 45
			$Tiro_drone.position.x = 68
			
		
		if Input.is_action_pressed("ui_right") and atack == false and atirar == false and !dano:
			idle = false
			run = true
			agachado = false
			direita()
			
		elif Input.is_action_pressed("ui_left") and atack == false and atirar == false and !dano:
			idle = false
			run = true
			agachado = false
			esquerda()
			
		elif Input.is_action_pressed("agachar") and atack == false and atirar == false and !dano:
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
			
			
		if agachado == false:
			$CollisionShape2D.disabled = false
				
		if Input.is_action_just_pressed("ataque") and !agachado and !ataqueUp and !dano and !nodrone:
			ataque()
		
		
		if Input.is_action_just_pressed("ataque1") and !agachado and !dano and !nodrone:
			ataque1()
		
			
		if Input.is_action_just_pressed("ataque2") and !agachado and !ataqueUp and !dano and !nodrone:
			ataque2()
		
			
		if flip == true:
			$AttackArea/CollisionShape2D.position.x = -21
			$AttackArea1/CollisionShape2D.position.x = -21
			$AttackArea2/CollisionShape2D.position.x = -30
		else:
			$AttackArea/CollisionShape2D.position.x = 19
			$AttackArea1/CollisionShape2D.position.x = 19
			$AttackArea2/CollisionShape2D.position.x = 25
		
		if Input.is_action_just_pressed("tiro") and atirar == false and balas > 0 and change_weapon == 1 and !nodrone:
			$TiroFx.play()
			shoot()
		
			
		#Contagem de balas
		$CanvasLayer/Label.set_text(String(balas))
		
		if Input.is_action_just_pressed("tiro") and atirar == false and granadas > 0 and change_weapon == 0 and !nodrone:
			jogargranada()
		$CanvasLayer/granadas.set_text(String(granadas))
		
		if Input.is_action_just_pressed("tiro") and atirar == false and missel > 0 and change_weapon == 2 and !nodrone:

			tirobazzoka()
		$CanvasLayer/misseis.set_text(String(missel))
		
		if Input.is_action_just_pressed("tiro") and atirar == false and escudo > 0 and change_weapon == 3 and !nodrone:
			
			get_shield()
		$CanvasLayer/barreira.set_text(String(escudo))
			
		
		if Input.is_action_just_pressed("tiro") and balas == 0 and change_weapon == 1:
			$clicFX.play()
		if Input.is_action_just_pressed("trocararma") and change_weapon == 1:
			get_node("CanvasLayer/selected").set_visible(false)
			get_node("CanvasLayer/selected2").set_visible(true)
			get_node("CanvasLayer/selected3").set_visible(false)
			get_node("CanvasLayer/selected4").set_visible(false)
			change_weapon -= 1
		
			
		elif change_weapon == 0 and Input.is_action_just_pressed("trocararma"):
			change_weapon += 2
			get_node("CanvasLayer/selected").set_visible(false)
			get_node("CanvasLayer/selected2").set_visible(false)
			get_node("CanvasLayer/selected3").set_visible(true)
			get_node("CanvasLayer/selected4").set_visible(false)
			
		elif change_weapon == 2 and Input.is_action_just_pressed("trocararma"):
			get_node("CanvasLayer/selected").set_visible(false)
			get_node("CanvasLayer/selected2").set_visible(false)
			get_node("CanvasLayer/selected3").set_visible(false)
			get_node("CanvasLayer/selected4").set_visible(true)
			change_weapon += 1
			
		elif change_weapon == 3 and Input.is_action_just_pressed("trocararma"):
			get_node("CanvasLayer/selected").set_visible(true)
			get_node("CanvasLayer/selected2").set_visible(false)
			get_node("CanvasLayer/selected3").set_visible(false)
			get_node("CanvasLayer/selected4").set_visible(false)
			change_weapon -= 2
		
		if is_on_floor():
			if Input.is_action_just_pressed("pulo") and !agachado and !nodrone:
				pular()
		else:
			if atack == false and noelevador == false and atirar == false and morreu == false and !dano:
				$Anim.play("Jump_R")
				if flip == true:
					$Anim.play("Jump_L")
		
		if movimento.y > 1000 and !nodrone:
			danogeral()
					
		movimento = move_and_slide(movimento, FLOOR_NORMAL)
		
		if damage < 1:
			morrer()
			morte()
			
		if nodrone:
			get_node("Ultra_drone").set_visible(true)
			$Ultra_drone.play()
			velocidade = 250
			get_node("Li_Sprites").set_visible(false)
			$Drone.disabled = false
			gravidade = 0
			if Input.is_action_pressed("pulo"):
				movimento.y -= 5
				
			if Input.is_action_pressed("agachar"):
				movimento.y += 5
				
			if Input.is_action_pressed("usar"):
				nodrone = false
				$Camera2D.get_node("Anim").play_backwards("Zoom_out")
				$CanvasLayer/HPplayer/Anim.play_backwards("Drone_HP")
				$DroneFX2.play()
				$Drone.disabled = true
				get_node("Li_Sprites").set_visible(true)
				get_node("Ultra_drone").set_visible(false)
				gravidade = 20
				velocidade = 120
				damage = 100
				get_node("CanvasLayer/HPplayer").value = int(damage)
				$DroneFX.stop()
				$Ultra_drone.stop()
			
				
			if Input.is_action_just_pressed("tiro"):
				shoot_drone()
		
		
		

			
		
		
func morte():
	$morrerFX.play()
	$Timer.start()
				
func _on_Timer_timeout():
	var _iniciar
	_iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
		
func direita():
	flip = false
	movimento.x = velocidade
	$Anim.play("Walk_R")
	if nodrone:
		$Ultra_drone.flip_h = false
func esquerda():
	flip = true
	movimento.x = - velocidade
	$Anim.play("Walk_L")
	if nodrone:
		$Ultra_drone.flip_h = true
	
func morrer():
	morreu = true
	if morreu == true:
		$Anim.play("Die")
		movimento = Vector2(0, 0)
		$CollisionShape2D.disabled = true
		$DashD/CollisionShape2D.disabled = true
		$DashE/CollisionShape2D.disabled = true
		
func _on_ResetAttack_timeout():
	atack = false
	dano = false
	parado()
	$AttackArea/CollisionShape2D.disabled = true
	$AttackArea2/CollisionShape2D.disabled = true
	
func _on_ataque1_timeout():
	atack = false
	dano = false
	ataqueUp = false
	parado()
	$AttackArea1/CollisionShape2D.disabled = true

		
func cartucho():
	balas += 15
	$clicFX.play()
	
func misseis():
	missel += 5
	
func getgranada():
	granadas += 5
	$socoforteFX.play()
func getbazooka():
	missel += 5
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
	$ShootReset.start()
	atirar = true
	$Anim.play("arremeco")
	if flip == true:
		$Anim.play("arremeco_L")

func get_shield():
	atack = true
	idle = false
	escudo -= 1
	if !idle and atack:
		$ResetAttack.start()
		$socofracoFX.play()
		var shield = SHIELD.instance()
		get_parent().add_child(shield)
		shield.position = $shield2.global_position
		$Anim.play("Shield_R")
		if flip:
			shield.position = $shield1.global_position
			$Anim.play("Shield_L")



func _on_ShootReset_timeout():
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
	get_node("CanvasLayer/HPplayer").value = int(damage)
func vidamedia():
	$lifeFX.play()
	if damage < 100:
		damage = damage + vida_media
	get_node("CanvasLayer/HPplayer").value = int(damage)
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


func _on_AttackArea1_body_entered(body):
	$punchforteFX.play()
	body.socoforte()


func _on_AttackArea2_body_entered(body):
	$kickFX.play()
	body.chute()

func danochefe():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danoboss
		$danotatuFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
func tiroboss():
	dano = true
	if dano == true:
		damage -= laserboss
		$laserexplodeFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)

func danotatu():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danocybertatu
		$danotatuFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
func ataqueSoldier():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danosoldier
		$danosocoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
	
		
func tirometranca():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danoatirador
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
func tirodrone():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danodrone
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
func granada():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)

func boombazuka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danobazuka
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)

func bazzoka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)

func socoboss():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= soco_boss
		$danoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
func tiro_bossDrone():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danoatirador
		$laserexplodeFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)

func tiro():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= danosoldier
		$danosocoFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
		
func laserghost():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danoatirador
		$danotatuFX.play()
		$Anim.play("Dano")
		$DanoReset.start()
		get_node("CanvasLayer/HPplayer").value = int(damage)
		
func _on_DanoReset_timeout():
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
		$AttackArea1/CollisionShape2D.disabled = false
		if flip == true:
			$Anim.play("Attack1_L")
			$AttackArea1/CollisionShape2D.disabled = false
			
func ataque2():
	atack = true
	idle = false
	$chuteFX.play()
	$ResetAttack.start()
	if atack == true and idle == false:
		$Anim.play("Kick_R")
		$AttackArea2/CollisionShape2D.disabled = false
		if flip == true:
			$Anim.play("Kick_L")
			$AttackArea2/CollisionShape2D.disabled = false

			
func shoot():
	if is_on_floor():
		get_node("Light2D").set_visible(true)
	
		movimento.x = 0
	balas -= 1
	var tiro = TIRO.instance()
	if sign($Tiro.position.x) >= 1:
		tiro.set_tiro_direction(1)
	else:
		tiro.set_tiro_direction(-1)
	get_parent().add_child(tiro)
	tiro.position = $Tiro.global_position
	$ShootReset.start()
	atirar = true
	$Anim.play("Shoot_R")
	if flip == true:
		$Anim.play("Shoot_L")
		
func shoot_drone():
	$tiro_drone.play()
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.position = $Tiro_drone.global_position
	if sign($Tiro_drone.position.x) <=0:
		bullet.set_bullet_direction(-1)
		bullet.rotation_degrees = 130
	
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
	
func armadilha():
	dano = true
	if dano == true:
		$DanoReset.start()
		$danoFX.play()
		$Anim.play("Dano")
		damage -= 100
		get_node("CanvasLayer/HPplayer").value = int(damage)	
			
func danogeral():
	dano = true
	if dano == true:
		$DanoReset.start()
		$danoFX.play()
		$Anim.play("Dano")
		damage -= DANOQUEDA
		get_node("CanvasLayer/HPplayer").value = int(damage)
		

# warning-ignore:unused_argument
func _on_Pulo_body_entered(body):
	if dano == false and !nodrone:
		pular()


func pular():
	movimento.y = PULO
	$PuloFX.play()

func agachar():
	if !nodrone:
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
	movimento.x = velocidade*10
	$Anim.play("Dano")
# warning-ignore:return_value_discarded
	move_and_slide(movimento)


func _on_DashE_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento.x = -velocidade*10
	$Anim.play("Dano")
# warning-ignore:return_value_discarded
	move_and_slide(movimento)
	

func getdrone():
	if !nodrone:
		damage = 150
		$Camera2D.get_node("Anim").play("Zoom_out")
		nodrone = true
	if nodrone:
		$DroneFX.play()
		$CanvasLayer/HPplayer/Anim.play("Drone_HP")
		

