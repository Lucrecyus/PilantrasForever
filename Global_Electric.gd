extends Node

var open = "0"

func _ready():
	
	open_gate()

func open_gate():
	if $GateRemtoControl.stage == "1":
		open = "1"
