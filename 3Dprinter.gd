extends Node2D

var imprimindo = false
var pegou = 0
const GETGRANADA = preload("res://Cenas/GetGranada.tscn")

func _ready():
	pass
	
func _process(_delta):
	if $Area2D.overlaps_body($"../Player") and Input.is_action_pressed("usar") and imprimindo == true:
		$Print.play()
		var getgranada = GETGRANADA.instance()
		get_parent().add_child(getgranada)
		getgranada.position = $Position2D.global_position
		pegou = 1
	if pegou >=1:
		imprimindo = false
		$Area2D/CollisionShape2D.disabled = true
	
func _on_Area2D_body_entered(_body):
	$AnimatedSprite.play("print")
	$Timer.start()

func _on_Timer_timeout():
	imprimindo = true
	$AnimatedSprite.play("idle")
