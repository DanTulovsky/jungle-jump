class_name Player extends CharacterBody2D

const ANIM_IDLE := &"idle"
const ANIM_RUN := &"run"
const ANIM_JUMP_UP := &"jump_up"
const ANIM_JUMP_DOWN := &"jump_down"
const ANIM_HURT := &"hurt"
const ANIM_DEAD := &"dead"

@export var gravity: float = 750
@export var run_speed: float = 150
@export var jump_speed: float = -300 # because "up" is in the negative y direction!


@onready var hsm: LimboHSM = $LimboHSM
@onready var idle_state: LimboState = $LimboHSM/idle
@onready var run_state: LimboState = $LimboHSM/run
@onready var jump_state: LimboState = $LimboHSM/jump
@onready var hurt_state: LimboState = $LimboHSM/hurt
@onready var dead_state: LimboState = $LimboHSM/dead

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	hsm.add_transition(idle_state, run_state, &"to_run")
	hsm.add_transition(idle_state, hurt_state, &"to_hurt")
	hsm.add_transition(idle_state, jump_state, &"to_jump")
	hsm.add_transition(run_state, hurt_state, &"to_hurt")
	hsm.add_transition(run_state, jump_state, &"to_jump")
	hsm.add_transition(run_state, idle_state, &"to_idle")
	hsm.add_transition(jump_state, idle_state, &"to_idle")
	hsm.add_transition(jump_state, run_state, &"to_run")
	hsm.add_transition(jump_state, hurt_state, &"to_hurt")
	hsm.add_transition(hurt_state, idle_state, &"to_idle")
	hsm.add_transition(hurt_state, dead_state, &"to_dead")

	hsm.update_mode = LimboHSM.PHYSICS
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _physics_process(delta):
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func reset(_position: Vector2) -> void:
	position = _position
	show()
	hsm.dispatch("to_idle")
