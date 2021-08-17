extends KinematicBody2D


var player = null
var move = Vector2.ZERO
var speed = 1
var damage = 100
var death = false
onready var TIRODRONE = preload("res://Cenas/Tirodrone.tscn")


func _physics_process(_delta):
	move = Vector2.ZERO
	if death == false:
	
		if player != null:
			$Anim.play("run")
			move = position.direction_to(player.position) * speed
			if move.x > 0:
				$drone.flip_h = false
			elif move.x < 0:
				$drone.flip_h = true
			
		else:
			$Anim.play("idle")
			move = Vector2.ZERO

		move = move.normalized()
		move = move_and_collide(move)
		
	if damage < 1:
			death = true
			die()

	
func _on_Area2D_body_entered(body):
	if body != self:
		player = body

func _on_Area2D_body_exited(_body):
	player = null
	
func fire():
	var tirodrone = TIRODRONE.instance()
	tirodrone.position = get_global_position()
	tirodrone.player = player
	$tiroFX.play()
	get_parent().add_child(tirodrone)
	$Timer.set_wait_time(1)
	
func soco():
	damage -= 50
	get_node("HP_Drone").value = int(damage)
	
func socoforte():
	damage -= 100
	get_node("HP_Drone").value = int(damage)
	
func chute():
	damage -= 100
	get_node("HP_Drone").value = int(damage)

func tiro():
	damage -= 100
	get_node("HP_Drone").value = int(damage)
func granada():
	damage -= 80
	get_node("HP_Drone").value = int(damage)

func bazzoka():
	damage -= 100
	get_node("HP_Drone").value = int(damage)
	
func boombazuka():
	damage -= 100
	get_node("HP_Drone").value = int(damage)
	
func bullet():
	damage -= 100
	get_node("HP_Drone").value = int(damage)

func die():
	move = Vector2(0,100)
	if death == true:
		$Anim.play("die")

func _on_Timer_timeout():
	if death == false:
		if player != null:
			fire()
	
