extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _process(_delta):
	if $".".overlaps_body($"../Player"):
		$AnimationPlayer.play("sumir")
	
func _on_GetBazooka_body_entered(body):
	body.getbazooka()
	
