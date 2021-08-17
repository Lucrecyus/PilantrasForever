extends KinematicBody2D

var damage = 100
export var danosoco = 20
export var dano_socoforte = 50
export var danochute = 100
export var danogranada = 100
export var danotiro = 100
export var danobazuca = 100
export var boombazuca = 100
var movimento = Vector2()
var velocidade = 150
var gravidade = 20
var detected = false


func _physics_process(_delta):
	

	movimento.y += gravidade
	
	if $Area2D.overlaps_body($"../Player"):
		movimento.x = velocidade
		$AnimatedSprite.play("Run")
		if $AnimatedSprite.flip_h == true:
			movimento.x = -velocidade
	if movimento.x == 0:
		$AnimatedSprite.play("Idle")
		
		
		
		
	if movimento.x > 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	movimento = move_and_slide(movimento)
	
		
	
	if damage < 1:
		morrer()

func soco():
	damage -= danosoco
	get_node("HP_Enemy").value = int(damage)
func socoforte():
	damage -= dano_socoforte
	get_node("HP_Enemy").value = int(damage)
func chute():
	damage -= danochute
	get_node("HP_Enemy").value = int(damage)
	if $AnimatedSprite.flip_h == true:
		movimento = Vector2(-400,-400)
	else:
		movimento = Vector2(400,-400)
func tiro():
	damage -= danotiro
	get_node("HP_Enemy").value = int(damage)
	
func granada():
	damage -= danogranada
	get_node("HP_Enemy").value = int(damage)
	
func bazzoka():
	damage -= danobazuca
	get_node("HP_Enemy").value = int(damage)

func boombazuka():
	damage -= boombazuca
	get_node("HP_Enemy").value = int(damage)
	
	
func bullet():
	damage -= boombazuca
	get_node("HP_Enemy").value = int(damage)

func _on_Area2D_body_entered(body):
	body.danotatu()


func _on_Detector_body_entered(_body):
	
	detected = true
	audiorun()
	$AnimatedSprite.play("Run")
	$AnimatedSprite.flip_h = false
	movimento.x = -velocidade
	

func _on_DetectorD_body_entered(_body):
	detected = true
	audiorun()
	$AnimatedSprite.play("Run")
	$AnimatedSprite.flip_h = true
	movimento.x = velocidade

	
func elevador():
	pass
	
func saiuelevador():
	pass


func _on_Detector_body_exited(_body):
	detected = false
	$AnimatedSprite.play("Run")
	$AnimatedSprite.flip_h = false
	movimento.x = -velocidade


func _on_DetectorD_body_exited(_body):
	detected = false
	$AnimatedSprite.play("Run")
	$AnimatedSprite.flip_h = true
	movimento.x = velocidade

func audiorun():
	if detected == true:
		$runFX.play()
func morrer():
	$AnimationPlayer.play("Death")
	$AnimatedSprite.play("Die")
	$Area2D/CollisionShape2D.disabled = true

