extends PlayerState


func _enter():
	player.anim_player.play(player.ANIM_JUMP_UP)

func _update(_delta):
	check_direction_input()
	# if player.is_on_floor():
	# 	dispatch("to_idle")

	if player.velocity.y > 0:
		player.anim_player.play(player.ANIM_JUMP_DOWN)
