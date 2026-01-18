extends PlayerState


func _enter():
	player.anim_player.play(player.ANIM_DEAD)

	player.died.emit()
	player.hide()
