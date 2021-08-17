extends Node2D


func _ready():
	get_tree().set_pause(false)


func _on_Fechar_gate_body_entered(_body):
	GameFases.open = "fechado"


func _on_SupremeSoldier2_tree_exited():
	$Armadilha17.queue_free()


func _on_Ghost_tree_exited():
	$Armadilha18.queue_free()
