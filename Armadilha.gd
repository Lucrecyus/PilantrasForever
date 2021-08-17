extends Node2D



func _ready():
	$Anim.play("laser")



func _on_Area2D_body_entered(body):
	body.armadilha()
	$LaserBate.play()
