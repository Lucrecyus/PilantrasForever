extends KinematicBody2D

var movimento = Vector2()
var velocidade = 100
var gravidade = 20
const UP = Vector2(0, -1)
export var damage = 100
export var danosoco = 10
export var dano_socoforte = 15
export var danochute = 20
export var danotiro = 50
export var danogranada = 100
export var danobazzoka = 100
var flip = false
var ataque = false
var dano = false

func _ready():
	$Soldier_sprites.flip_h = true

func _physics_process(_delta):
	movimento.y += gravidade
	if movimento.x == 0 and ataque == false and dano == false:
		$AnimationPlayer.play("Idle")
	if flip == true:
		$AtackDetector/CollisionShape2D.position.x = 0
	
	else:
		$AtackDetector/CollisionShape2D.position.x = 46
	if movimento.y > 900:
		danoqueda()
	
	movimento = move_and_slide(movimento, UP)
	
	if damage < 1:
		die()
	if ataque == false:
		$AtackDetector/CollisionShape2D.disabled = true


func soco():
	dano = true
	if dano == true:
		$DanoGolpes.start()
		damage -= danosoco
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
func socoforte():
	dano = true
	if dano == true:
		$DanoGolpes.start()
		damage -= dano_socoforte
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
func chute():
	dano = true
	if dano == true:
		movimento = Vector2(0,-200)	
		$DanoGolpes.start()
		damage -= danochute
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
func tiro():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danotiro
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)

func granada():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danogranada
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)

func bazzoka():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
		
func boombazuka():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
		
func bullet():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)
	 
func danoqueda():
	dano = true
	if dano == true:
		movimento = Vector2(0,0)
		$ResetDano.start()
		damage -= danobazzoka
		$AnimationPlayer.play("dano")
		get_node("HP_Soldier").value = int(damage)	
	
	
func elevador():
	pass
	
func saiuelevador():
	pass



func _on_DetectorD_body_entered(_body):
	if ataque == false and dano == false:
		movimento.x = velocidade
		flip = false
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = false
	


func _on_DetectorE_body_entered(_body):
	if ataque == false and dano == false:
		movimento.x = -velocidade
		flip = true
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = true


		

func _on_AtackDetector_body_entered(body):
	body.ataqueSoldier()


	
func _on_DetectorD_body_exited(_body):
	if ataque == false and dano == false:
		movimento.x = velocidade
		flip = false
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = false


func _on_DetectorE_body_exited(_body):
	if ataque == false and dano == false:
		movimento.x = -velocidade
		flip = true
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = true
	

func die():
	ataque = true
	dano = true
	movimento = Vector2(0,0)
	$AnimationPlayer.play("die")
	$CollisionShape2D.disabled = true
	gravidade = 0
	$AtackDetector/CollisionShape2D.disabled = true
	

func _on_ResetDano_timeout():
	dano = false
	movimento = Vector2()
	if flip == true and ataque == false:
		movimento.x = -velocidade
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = true
	if flip == false and ataque == false:
		movimento.x = velocidade
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = false
		
		
func _on_DanoGolpes_timeout():
	dano = false
	movimento = Vector2()
	if flip == true and ataque == false:
		movimento.x = -velocidade
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = true
	if flip == false and ataque == false:
		movimento.x = velocidade
		$AnimationPlayer.play("Walk")
		$Soldier_sprites.flip_h = false

	

func _on_CanAttack_body_entered(_body):
		$ResetAttack.start()

func _on_CanAttack_body_exited(_body):
	ataque = false
	$ResetAttack.stop()
	
func _on_ResetAttack_timeout():
	ataque = false
	attack()

func attack():
	ataque = true
	if ataque == true and dano == false:
		$SocoFX.play()
		$AnimationPlayer.play("Soco")
		movimento.x = 0
		$AtackDetector/CollisionShape2D.disabled = false
		$ResetAttack.start()
		$Timer.start()
	

func _on_Dash_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento.x = -20

func _on_Dash2_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento.x = 20


func _on_Timer_timeout():
	ataque = false
