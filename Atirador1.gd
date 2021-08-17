extends KinematicBody2D

var ataque = false
var parado = true
var dano = false
var damage = 100
const TIROMETRANCA = preload("res://Cenas/TiroMetranca.tscn")

func _process(_delta):
	idle()
	if damage < 1:
		die()

func _on_DetectorD_body_entered(_body):
	$Soldier_sprites.flip_h = false
	$Position2D.position.x = 23
	parado = false
	atirar()



func _on_DetectorE_body_entered(_body):
	$Soldier_sprites.flip_h = true
	$Position2D.position.x = -23
	parado = false
	atirar()


func atirar():
	ataque = true
	if ataque == true:
		$AnimationPlayer.play("atirar")
		$Timer.start()
		$TirodozeFX.play()
		var tirometranca = TIROMETRANCA.instance()
		tirometranca.set_tiro_direction(1)
		get_parent().call_deferred("add_child",tirometranca)
		tirometranca.position = $Position2D.global_position
		if $Soldier_sprites.flip_h == true:
			tirometranca.set_tiro_direction(-1)
			tirometranca.position = $Position2D.global_position	

func _on_DetectorD_body_exited(_body):
	ataque = false
	parado = true
	$Timer.stop()

func _on_DetectorE_body_exited(_body):
	ataque = false
	parado = true
	$Timer.stop()

func idle():
	if parado == true and ataque == false:
		$AnimationPlayer.play("idle")
		
func die():
	parado = false
	$AnimationPlayer.play("die")
	

func _on_Timer_timeout():
	ataque = false
	atirar()
	
func soco():
	dano = true
	damage -= 10
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
	
func socoforte():
	dano = true
	damage -= 20
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
	
func chute():
	dano = true
	damage -= 30
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)

func tiro():
	dano = true
	damage -= 50
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)

func granada():
	dano = true
	damage -= 100
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
func bazzoka():
	dano = true
	damage -= 100
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
func boombazuka():
	dano = true
	damage -= 100
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
	
func bullet():
	dano = true
	damage -= 100
	$AnimationPlayer.play("dano")
	get_node("HP_Soldier").value = int(damage)
	
