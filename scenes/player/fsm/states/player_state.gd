class_name PlayerState extends LimboState

var player: Player:
    get:
        return agent as Player

func check_direction_input() -> void:
    var input_dir := Input.get_axis("left", "right")
    if input_dir != 0:
        player.velocity.x = input_dir * player.run_speed
        player.sprite.flip_h = input_dir < 0
        if player.is_on_floor():
            dispatch(&"to_run")
    else:
        player.velocity.x = 0
        if player.is_on_floor():
            dispatch(&"to_idle")

func check_jump_input() -> void:
    if Input.is_action_just_pressed("jump") and player.is_on_floor():
        player.velocity.y = player.jump_speed
        dispatch(&"to_jump")

func check_if_in_air() -> void:
    if !player.is_on_floor():
        dispatch(&"to_jump")
