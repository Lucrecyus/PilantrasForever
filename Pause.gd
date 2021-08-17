extends Control

var pause = false
var iniciar


func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		pause = true


	if Input.is_action_pressed("quit") and pause:
		iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
	
