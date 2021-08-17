extends Node2D

var dialogo = false


func _ready():
	get_tree().set_pause(false)

func _process(_delta):
	if !dialogo:
		get_node("dialogo1").set_visible(false)
		get_node("dialogo2").set_visible(false)
	

func _on_Fechar_gate_body_entered(_body):
	GameFases.open = "fechado"


func _on_Boss_tree_exited():
	$Gate2.queue_free()


func _on_Vant5_tree_exited():
	$Parede.queue_free()


func _on_Timer_timeout():
	get_tree().set_pause(true)
	dialogo = true
	$Fim.start()
	get_node("dialogo1").set_visible(true)

func _on_Fim_timeout():
	get_tree().set_pause(false)
	dialogo = false


func _on_Ghost_tree_exited():
	$Final_dialogo.start()


func _on_Final_dialogo_timeout():
	$Mudar_fase.start()
	dialogo = true
	$dialogo2.position = $Player.global_position
	get_node("dialogo2").set_visible(true)
	get_tree().set_pause(true)


func _on_Mudar_fase_timeout():
	GameFases.stage3 = "complete"
	GameFases.save_data()
	$Anim.play("fade_out")
	$Sair.start()

func _on_Sair_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cenas/SelectFases.tscn")
