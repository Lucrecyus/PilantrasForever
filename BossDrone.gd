extends KinematicBody2D

var velocidade = 2
var pos_inicial
var pos_final
var flip = true
const DRONES = preload("res://Cenas/Drone.tscn")
const TIROBOSS = preload("res://Cenas/TiroBoss_drone.tscn")
var player = null
var statusBoss = false
var damage = 100
var danosoco = 1
var danochute = 2
var danosoco_forte = 3
var danotiro = 5
var danogranada = 10
var danobazuca = 30
var danoboombazuca = 50
var death = false

func _ready():
	$Anim.play("Idle")
	pos_inicial = $".".position.x
	pos_final = pos_inicial + 600
	
func _process(_delta):
	
	if statusBoss == false:
		get_node("CanvasLayer/HP").set_visible(false)
		get_node("CanvasLayer/Label").set_visible(false)
	else:
		get_node("CanvasLayer/HP").set_visible(true)
		get_node("CanvasLayer/Label").set_visible(true)
		
	if pos_inicial <= pos_final and flip:
		$".".position.x += velocidade
		$BossDrone.flip_h = true
		if $".".position.x >= pos_final:
			flip = false
			
	if $".".position.x >= pos_inicial and !flip:
		$BossDrone.flip_h = false
		$".".position.x -= velocidade
		if $".".position.x <= pos_inicial:
			flip = true
	if damage <= 0:
		die()
	if damage <= 50:
		velocidade = 5
func _deploy_drone():
	var drones = DRONES.instance()
	get_parent().add_child(drones)
	drones.position = $Pos_drone.global_position
func _tirobossDrone():
	var tiroboss = TIROBOSS.instance()
	tiroboss.position = get_global_position()
	tiroboss.player = player
	$Tiroboss.play()
	get_parent().add_child(tiroboss)

func _on_Drones_timeout():
	if death == false:
		_deploy_drone()
	
func _on_Tiro_timeout():
	_tirobossDrone()
	
func _on_Detector_body_entered(_body):
	if _body != self:
		player = _body
	$Drones.start()
	$Tiro.start()
	statusBoss = true
	$flying.play()
	
func _on_Detector_body_exited(_body):
	$Drones.stop()
	$Tiro.stop()
	player = null
	
func die():
	death = true
	$flying.stop()
	$".".position.y += 2
	velocidade = 2
	$Anim.play("die")


	
func soco():
	damage -= danosoco
	get_node("CanvasLayer/HP").value = int(damage)
func chute():
	damage -= danochute
	get_node("CanvasLayer/HP").value = int(damage)
func socoforte():
	damage -= danosoco_forte
	get_node("CanvasLayer/HP").value = int(damage)
func tiro():
	damage -= danotiro
	get_node("CanvasLayer/HP").value = int(damage)
func granada():
	damage -= danogranada
	get_node("CanvasLayer/HP").value = int(damage)
func bazzoka():
	damage -= danobazuca
	get_node("CanvasLayer/HP").value = int(damage)
func boombazuka():
	damage -= danoboombazuca
	get_node("CanvasLayer/HP").value = int(damage)
func bullet():
	damage -= danogranada
	get_node("CanvasLayer/HP").value = int(damage)
