extends Node2D


var _dialogo1


func _ready():
	

	get_tree().set_pause(false)

	
func _process(_delta):
	
	pass


	if _dialogo1 == false:
		get_node("Dialogo1").set_visible(false)
		
	if _dialogo1 == true:
		get_node("Dialogo1").set_visible(true)
		
	$Dialogo5.position = $Player.global_position
	
		
func _on_FimDialogo_timeout():
	_dialogo1 = false
	get_tree().set_pause(false)
	
func _on_EntrarDialogo_timeout():
	_dialogo1 = true
	get_tree().set_pause(true)	
	
func _on_Boss_tree_exited():
	get_node("Dialogo5").set_visible(true)
	$mudarfase.start()


func _on_mudarfase_timeout():
	GameFases.stage1 = "complete"
	GameFases.save_data()
	$Anim.play("fadeout")
	$sair.start()

func _on_sair_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cenas/SelectFases.tscn")

func _on_Print_hint_body_entered(_body):
	get_node("Print_hint/ColorRect").set_visible(true)

func _on_Print_hint_body_exited(_body):
	get_node("Print_hint/ColorRect").set_visible(false)
	
func _on_Area2D_body_entered(_body):
	get_node("Dialogo2").set_visible(true)
	$TimerDialogo2.start()


func _on_TimerDialogo2_timeout():
	get_node("Dialogo2").set_visible(false)
	get_node("Dialogo3").set_visible(false)
	get_node("Dialogo4").set_visible(false)

func _on_CyberTatu_tree_exited():
	$TimerDialogo2.start()
	get_node("Dialogo2").set_visible(true)

func _on_Atirador1_tree_exited():
	$TimerDialogo2.start()
	get_node("Dialogo3").set_visible(true)

func _on_Atirador2_tree_exited():
	$TimerDialogo2.start()
	get_node("Dialogo4").set_visible(true)


func _on_Gate_hint_body_entered(_body):
	get_node("Gate_hint/ColorRect").set_visible(true)


func _on_Gate_hint_body_exited(_body):
	get_node("Gate_hint/ColorRect").set_visible(false)


func _on_BossTheme_body_entered(_body):
	$AudioStreamPlayer.stop()
	$BossTrilha.play()




func _on_Fechar_gate_body_entered(_body):
	GameFases.open = "fechado"
