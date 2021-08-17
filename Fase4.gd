extends Node2D

var is_on_floor = false

func _ready():
	get_tree().set_pause(false)

	$Start_dialogo.start()
	
func _process(_delta):
	$dialogo2.position = $Player.global_position
	if is_on_floor and Input.is_action_pressed("usar"):
		$dialogo2.set_visible(true)
		$Mission_failed.start()

func _on_Start_dialogo_timeout():
	
	$End_dialogo.start()
	get_tree().set_pause(true)
	$dialogo1.set_visible(true)


func _on_End_dialogo_timeout():
	get_tree().set_pause(false)
	$dialogo1.set_visible(false)


func _on_Floor_body_shape_entered(_body_id, _body, _body_shape, _area_shape):
	is_on_floor = true
	


func _on_Mission_failed_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_Final_body_entered(_body):
	get_tree().set_pause(true)
	$dialogo3.set_visible(true)
	$dialogo3.position = $Player.position
	$End_stage.start()


func _on_End_stage_timeout():
	GameFases.stage4 = "complete"
	GameFases.save_data()
	$Anim.play("fade_out")
	$Sair.start()
	


func _on_Sair_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cenas/SelectFases.tscn")
