extends Node2D

var dialogo
var dialogo1

func _ready():
	get_tree().set_pause(false)

func _process(_delta):
	if dialogo == true:
		get_node("Dialogo").set_visible(true)
	if dialogo == false:
		get_node("Dialogo").set_visible(false)

func _on_EntraDialogo_timeout():
	dialogo = true
	get_tree().set_pause(true)
	
func _on_FimDialogo_timeout():
	dialogo = false
	get_tree().set_pause(false)


func _on_BossDrone_tree_exited():
	$FinalDialogo.start()

func _on_FinalDialogo_timeout():
	$Dialogo1.position = $Player.global_position
	get_node("Dialogo1").set_visible(true)
	get_tree().set_pause(true)
	$mudarfase.start()

func _on_mudarfase_timeout():
	GameFases.stage2 = "complete"
	GameFases.save_data()
	$Anim.play("fadeout")
	$sair.start()

func _on_sair_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cenas/SelectFases.tscn")


func _on_Fechar_gate_body_entered(_body):
	GameFases.open = "fechado"
