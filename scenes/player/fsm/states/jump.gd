extends PlayerState


func _enter():
	player.anim_player.play(player.ANIM_JUMP_UP)

func _update(_delta):
	if player.velocity.y > 0:
		player.anim_player.play(player.ANIM_JUMP_DOWN)

	check_direction_input()
	check_collisions()

