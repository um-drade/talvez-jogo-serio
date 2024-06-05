extends Area2D


func _on_body_entered(body):
	if body.has_method("player"):
		if !body.qntmunicao:
			body.gerararma()
		body.qntmunicao += 1
		print(body.qntmunicao)
		queue_free()
