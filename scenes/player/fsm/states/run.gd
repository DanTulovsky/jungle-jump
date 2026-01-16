extends PlayerState


func _enter():
	player.anim_player.play(player.ANIM_RUN)

func _update(_delta: float) -> void:
	check_direction_input()
	check_jump_input()
	check_if_in_air()
