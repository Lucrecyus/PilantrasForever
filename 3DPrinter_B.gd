extends Node2D


var imprimindo = false
var pegou = 0
const GETBAZOOKA = preload("res://Cenas/GetBazooka.tscn")

func _ready():
	if imprimindo == false:
		$Anim.play("Idle")
	
func _process(_delta):
	if $Area2D.overlaps_body($"../Player") and Input.is_action_pressed("usar") and imprimindo == true:
		$Print.play()
		var getbazooka = GETBAZOOKA.instance()
		get_parent().add_child(getbazooka)
		getbazooka.position = $Position2D.global_position
		pegou = 1
	if pegou >=1:
		imprimindo = false
		$Area2D/CollisionShape2D.disabled = true
	
func _on_Area2D_body_entered(_body):
	$Anim.play("Print")
	$Timer.start()

func _on_Timer_timeout():
	imprimindo = true
	$Anim.play("Idle")
