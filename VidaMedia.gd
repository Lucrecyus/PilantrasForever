extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _process(_delta):
	if $".".overlaps_body($"../Player"):
		anim_player.play("sumir")

func _on_VidaMedia_body_entered(body):
	body.vidamedia()
	
