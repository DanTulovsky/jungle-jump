extends CharacterBody2D

@export var speed: float = 25
@export var gravity: float = 900

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

var facing = 1

func _ready() -> void:
	anim.play("walk")

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = facing * speed
	sprite.flip_h = velocity.x > 0

	move_and_slide()

	for i in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if collision.get_collider().name == "Player":
			collision.get_collider().hurt()
		if collision.get_normal().x != 0:
			facing = sign(collision.get_normal().x)
			velocity.y = -100

	if position.y > 10000:
		queue_free()

func take_damage() -> void:
	anim.play("death")
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
