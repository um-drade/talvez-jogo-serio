extends Area2D



func _on_body_entered(body):
	if body.has_method("player"):
		get_node("/root/mundo/player").velocity.y = -800
		$AnimatedSprite2D.play()
		$AudioStreamPlayer.play(.8)
