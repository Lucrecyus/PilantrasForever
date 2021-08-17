extends KinematicBody2D


func _process(_delta):
	$Anim.play("move")

func _on_Area2D_body_entered(body):
	body.elevador()

func elevador():
	pass
func soco():
	pass
func socoforte():
	pass
func chute():
	pass
func granada():
	pass

func _on_Area2D_body_exited(body):
	body.saiuelevador()
func saiuelevador():
	pass
func danotatu():
	pass
	
func ataqueSoldier():
	pass

