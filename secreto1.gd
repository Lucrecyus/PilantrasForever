extends StaticBody2D

var damage = 100


func _process(_delta):
	if damage <= 0:
		_sumir()

func _ready():
	$Anim.play("normal")
	
func _sumir():
	$Anim.play("sumir")

func soco():

	damage -= 20

func socoforte():

	damage -= 30
	
func chute():

	damage -= 40
	
func tiro():
	damage -= 50

func granada():
	damage -= 80

func bazzoka():
	damage -= 90
		
func boombazuka():
	damage -= 100

func bullet():
	damage -= 100
