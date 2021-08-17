extends Control

var iniciar

func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus()

func _process(_delta):
	if GameFases.stage1 == "complete":
		$CenterContainer/VBoxContainer/Button/Anim.play("complete")
	if GameFases.stage2 == "complete":
		get_node("CenterContainer/VBoxContainer/Button3").set_visible(true)
		$CenterContainer/VBoxContainer/Button2/Anim2.play("complete")
	if GameFases.stage3 == "complete":
		get_node("CenterContainer/VBoxContainer/Button4").set_visible(true)
		$CenterContainer/VBoxContainer/Button3/Anim3.play("complete")
	if GameFases.stage4 == "complete":
		get_node("CenterContainer/VBoxContainer/Button5").set_visible(true)
		$CenterContainer/VBoxContainer/Button4/Anim4.play("complete")	
		
	if Input.is_action_pressed("agachar"):
		audio()
	if Input.is_action_pressed("cima"):
		audio()
		
		
func _on_Button_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase1.tscn")
	

func _on_Button2_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase2.tscn")

func _on_Button3_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase3.tscn")

func _on_Button4_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase4.tscn")

func _on_Button5_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase5.tscn")

func _on_back_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_Reset_pressed():
	GameFases.stage1 = "incomplete"
	GameFases.stage2 = "incomplete"
	GameFases.stage3 = "incomplete"
	GameFases.stage4 = "incomplete"
	GameFases.stage5 = "incomplete"
	GameFases.stage6 = "incomplete"
	GameFases.stage7 = "incomplete"
	GameFases.stage8 = "incomplete"
	GameFases.save_data()
	iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")

func audio():
	$select.play()



