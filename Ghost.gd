extends KinematicBody2D

var velocidade = 15
var pos_inicial
var pos_final
var flip = false
var dano = false
var atirando = false
var tiros = 4
var damage = 100
const LASER = preload("res://Cenas/Laser_ghost.tscn")
var statusBoss = false
var vivo = true

func _ready():

	
	pos_inicial = $".".position.x
	pos_final = pos_inicial - 500

	
func _process(_delta):
	if vivo:
		if	statusBoss == false:
			get_node("CanvasLayer/HP").set_visible(false)
			get_node("CanvasLayer/Label").set_visible(false)
		else:
			get_node("CanvasLayer/HP").set_visible(true)
			get_node("CanvasLayer/Label").set_visible(true)
	
		if flip:
			$Position2D.position.x = 32
			$Ghost_sprites.flip_h = true
		else:
			$Position2D.position.x = -32
			$Ghost_sprites.flip_h = false
	
		if dano:	
			if pos_inicial >= pos_final and !flip:
				_run()
				if $".".position.x <= pos_final:
					flip = true
			
			if pos_final <= pos_inicial and flip:
				_back()
				if $".".position.x >= pos_inicial:
					flip = false
				
			else:
				_idle()
		
	if damage <= 0:
		death()
		
func _idle():
	if !atirando:
		$".".position.x += 0
		$Anim.play("Idle")
	
		
func _run():
	
	$".".position.x -= velocidade
	$Anim.play("Invisible")
	tiros = 4
	$Detector_D/CollisionShape2D.disabled = true
	$Detector_E/CollisionShape2D.disabled = true

	
func _back():
	$".".position.x += velocidade
	$Anim.play("Invisible")
	tiros = 4
	$Detector_D/CollisionShape2D.disabled = true
	$Detector_E/CollisionShape2D.disabled = true
	
	
func _shot():
	$Shot_reset.start()
	tiros -= 1
	$".".position.x += 0
	$Anim.play("Shot")
	$Detector_D/CollisionShape2D.disabled = false
	$Detector_E/CollisionShape2D.disabled = false
	
	
func soco():
	damage -= 1
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)
	
func chute():
	damage -= 2
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)
	
func socoforte():
	damage -= 3
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)

func tiro():
	damage -= 2
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)
		
func granada():
	damage -= 8
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)
func bazzoka():
	damage -= 5
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)	
func boombazuka():
	damage -= 10
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)

func bullet():
	damage -= 10
	$Reset_dano.start()
	dano = true
	get_node("CanvasLayer/HP").value = int(damage)
	

func _on_Reset_dano_timeout():
	dano = false

func _on_Shot_start_timeout():
	if vivo:
		atirando = true
		_shot()

func _on_Detector_D_body_entered(_body):
	$Ghost_sprites.flip_h = true
	flip = true
	

func _on_Detector_E_body_entered(_body):
	$Ghost_sprites.flip_h = false
	flip = false


func _on_Shot_reset_timeout():
	atirando = false
	$Shot_start.start()

func laser():
	$Laser.play()
	var laser = LASER.instance()
	if sign($Position2D.position.x) == 46:
		laser.set_laser_direction(1)
	else:
		laser.set_laser_direction(1)
		get_parent().add_child(laser)
		laser.position = $Position2D.global_position
	if $Ghost_sprites.flip_h == false:
		laser.set_laser_direction(-1)
		laser.position = $Position2D.global_position


func _on_VisibilityNotifier2D_screen_entered():
		$Shot_start.start()
		statusBoss = true
func death():
	vivo = false
	$Shot_start.stop()
	$Shot_reset.stop()
	$Anim.play("Die")
	$Colisor.disabled = true
