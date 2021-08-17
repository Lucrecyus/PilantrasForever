extends StaticBody2D

var voar = -0.5
var descer = 0.3
var pos_inicial
var pos_final
var teto = true
var die = false


func _ready():
	$Anim.play("flying")
	pos_inicial = $".".position.y
	pos_final = pos_inicial - 30
	
	
func _process(_delta):
	if !die:	
		if pos_inicial >= pos_final and teto:
			$".".position.y += voar
			if $".".position.y <= pos_final:
				teto = false
		if $".".position.y <= pos_inicial and !teto:
			$".".position.y += descer
			if $".".position.y >= pos_inicial:
				teto = true
	else:
		$Anim.play("Death")
	
	#--------------------DANOS--------------------------


func _on_Detector_body_entered(_body):
	die = true
