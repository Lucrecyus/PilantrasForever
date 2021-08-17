extends Node2D

var state = "0"


func _process(_delta):
	
	if state == "1":
		$Anim.play("Open")

	if $Colisor.overlaps_body($"../Player") and Input.is_action_pressed("usar"):
		GameFases.open = "aberto"
		$openFX.play()
		state = "1"
		if state == "1":
			$Anim.play("Locked")
	
	
