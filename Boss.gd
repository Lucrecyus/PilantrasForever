extends KinematicBody2D

var movimento = Vector2()
var velocidade = 70
var gravidade = 20
const PULO = - 500
const FLOOR_NORMAL = Vector2(0, -1)
var jump = false
var walk = false
var idle = false
var atack = false
var flip = false
var damage = 100
var shield = 100
var dano = false
const TIROBOSS = preload("res://Cenas/TiroBoss.tscn")
var statusBoss = false
var morte = false

func _ready():
	set_process(true)

func _process(_delta):
	if statusBoss == false:
		get_node("CanvasLayer/HPBoss").set_visible(false)
		get_node("CanvasLayer/ShieldBoss").set_visible(false)
		get_node("CanvasLayer/Label").set_visible(false)
	else:
		get_node("CanvasLayer/HPBoss").set_visible(true)
		get_node("CanvasLayer/ShieldBoss").set_visible(true)
		get_node("CanvasLayer/Label").set_visible(true)
	
func _physics_process(_delta):
	movimento.y += gravidade
	if damage <=0:
		morrer()
	if flip == true:
		$Position2D.position.x = -36
	else:
		$Position2D.position.x = 36

	movimento = move_and_slide(movimento, FLOOR_NORMAL)
	
func _on_detectorD_body_entered(_body):
	$Ativarpulo.start()
	andar()
	
func _on_detectorE_body_entered(_body):
	$Ativarpulo.start()
	andarE()
	
func andar():
	walk = true
	if walk == true:
		atack = false
		flip = false
		movimento.x = velocidade
		$Sprite.flip_h = false
		$AnimationPlayer.play("walk")
	
func andarE():
	walk = true
	if walk == true:
		atack = false
		flip = true
		movimento.x = -velocidade
		$Sprite.flip_h = true
		$AnimationPlayer.play("walk")
		
func pular():
	if morte == false:
		jump = true
		movimento.y = PULO
		$AnimationPlayer.play("pulo")

func parado():
	idle = true
	atack = true
	$AnimationPlayer.play("idle")
	movimento.x = 0
	$preataque.start()
	$pretiro.play()
	
func ataque():
	if atack == true:
		$ataquefisico/CollisionShape2D.disabled = false
		if shield >= 0:
			get_node("AnimatedSprite").set_visible(true)
			get_node("Light2D").set_visible(true)
			barreira()
		atirar()
		$tiroBoss.play()
		$AnimationPlayer.play("ataque")
	else:
		$ataquefisico/CollisionShape2D.disabled = true
		get_node("AnimatedSprite").set_visible(false)
		get_node("Light2D").set_visible(false)

func _on_detectorE_body_exited(_body):
	walk = false

func _on_detectorD_body_exited(_body):
	walk = false


func _on_Ativarpulo_timeout():
	$pospulo.start()
	walk = false
	pular()

func _on_pospulo_timeout():
	parado()

func _on_salto2_body_entered(_body):
	_body.danochefe()
	pular()

func _on_preataque_timeout():
	$posataque.start()
	ataque()


func _on_posataque_timeout():
	parado()

func soco():
	dano = true
	if dano == true:
		shield -= 3
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 1
		get_node("CanvasLayer/HPBoss").value = int(damage)
		
func socoforte():
	dano = true
	if dano == true:
		shield -= 8
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 5
		get_node("CanvasLayer/HPBoss").value = int(damage)
		
func chute():
	dano = true
	if dano == true:	
		shield -= 5
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 1
		get_node("CanvasLayer/HPBoss").value = int(damage)
		
func tiro():
	dano = true
	if dano == true and shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 10
		get_node("CanvasLayer/HPBoss").value = int(damage)
	else:
		$AnimationPlayer.play("danoshield")
		get_node("dialogo").set_visible(true)
		$desativarDialogo.start()
		
func granada():
	dano = true
	if dano == true:	
		shield -= 8
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 30
		get_node("CanvasLayer/HPBoss").value = int(damage)

func bazzoka():
	dano = true
	if dano == true:	
		shield -= 8
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 20
		get_node("CanvasLayer/HPBoss").value = int(damage)
		
func boombazuka():
	dano = true
	if dano == true:	
		shield -= 12
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 50
		get_node("CanvasLayer/HPBoss").value = int(damage)
		
func bullet():
	dano = true
	if dano == true:	
		shield -= 12
		$AnimationPlayer.play("danoshield")
		get_node("CanvasLayer/ShieldBoss").value = int(shield)
	if shield <= 0:
		$AnimationPlayer.play("dano")
		damage -= 20
		get_node("CanvasLayer/HPBoss").value = int(damage)
	
func morrer():
	morte = true
	atack = false
	movimento.x = 0
	$AnimationPlayer.play("death")
	$CollisionShape2D.disabled = true
	$ataquefisico/CollisionShape2D.disabled = true
	$salto2/CollisionShape2D.disabled = true
	gravidade = 0
	movimento.y = 0
	
func atirar():
	var tiroboss = TIROBOSS.instance()
	if sign($Position2D.position.x) == 36:
		tiroboss.set_tiro_direction(1)
	else:
		tiroboss.set_tiro_direction(-1)
		get_parent().add_child(tiroboss)
		tiroboss.position = $Position2D.global_position
	if $Sprite.flip_h == false:
		tiroboss.set_tiro_direction(1)
		tiroboss.position = $Position2D.global_position
	

func _on_VisibilityNotifier2D_screen_entered():
	statusBoss = true

func _on_desativarDialogo_timeout():
	get_node("dialogo").set_visible(false)


func _on_ataquefisico_body_entered(body):
	body.socoboss()
	
func socoboss():
	pass

func barreira():
	$AnimatedSprite.play("barreira")
