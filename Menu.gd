extends Control

var iniciar

func _ready():

	$CenterContainer/VBoxContainer/Start.grab_focus()

func _process(_delta):
	if GameFases.stage1 == "complete":
		$CenterContainer/VBoxContainer/QG.disabled = false
	if Input.is_action_pressed("agachar"):
		audio()
	if Input.is_action_pressed("cima"):
		audio()

func _on_Start_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase1.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_QG_pressed():
	iniciar = get_tree().change_scene("res://Cenas/SelectFases.tscn")
	
func audio():
	$select.play()
