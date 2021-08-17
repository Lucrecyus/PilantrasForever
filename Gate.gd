extends StaticBody2D

var vel = -0.8
var vel2 = 0.8
var pos_inicial 
var pos_final
var state = 0

func _ready():
	pos_inicial = $".".position.y
	pos_final = pos_inicial - 100



func _process(_delta):
	if GameFases.open == "aberto":
		
		$".".position.y += vel
		
	if $".".position.y <= pos_final:
		vel = 0
		state = 1
	if GameFases.open == "fechado" and state == 1:
		$".".position.y += vel2
		if $".".position.y >= pos_inicial:
			vel = -0.8
			state = 0



func danotatu():
	pass
func soco():
	pass
func socoforte():
	pass
func chute():
	pass
func tiro():
	pass
func tirodrone():
	pass
func tirometranca():
	pass

