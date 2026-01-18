extends PlayerState


func _enter():
	player.anim_player.play(player.ANIM_HURT)

	# bounce away from the hurt object
	player.velocity = Vector2(-100*sign(player.velocity.x), -200)

	player.life -= 1

	await get_tree().create_timer(0.5).timeout
	dispatch("to_idle")

