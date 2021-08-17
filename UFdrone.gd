extends Area2D





func _on_UFdrone_body_entered(body):
	body.getdrone()
	queue_free()
