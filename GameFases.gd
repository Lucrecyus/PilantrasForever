extends Node


var stage1 = "incomplete"
var stage2 = "incomplete"
var stage3 = "incomplete"
var stage4 = "incomplete"
var stage5 = "incomplete"
var stage6 = "incomplete"
var stage7 = "incomplete"
var stage8 = "incomplete"
var open = "fechado"


const save_path = "user://save.dat"


func _ready():
	load_data()
func save_data():
	var data = {"stage1": stage1, 
	"stage2": stage2, "stage3": stage3, "stage4": stage4,
	"stage5": stage5, "stage6": stage6, "stage7": stage7, "stage8": stage8,
	}
	var file = File.new()
	var error =  file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()

func load_data():
	var file = File.new()
	if file.file_exists(save_path):

		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			file.close()

			stage1 = data["stage1"]
			stage2 = data["stage2"]
			stage3 = data["stage3"]
			stage4 = data["stage4"]
			stage5 = data["stage5"]
			stage6 = data["stage6"]
			stage7 = data["stage7"]
			stage8 = data["stage8"]
	
		
		
			

	
	
	

