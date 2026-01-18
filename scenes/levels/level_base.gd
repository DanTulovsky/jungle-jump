extends Node2D

signal score_changed

@onready var state_label: Label = $TempDebug/MarginContainer/StateLabel

var item_scene = load("res://scenes/items/item.tscn")
var score: float = 0:
	set(value):
		score = value
		score_changed.emit(score)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Items.hide()
	spawn_items()
	$Player.reset($SpawnPoint.position)

	set_camera_limits()

func set_camera_limits():
	var map_size = $World.get_used_rect()
	var cell_size = $World.tile_set.tile_size
	$Player/Camera2D.limit_left = (map_size.position.x - 5) * cell_size.x
	$Player/Camera2D.limit_right = (map_size.end.x + 5) * cell_size.x

func spawn_items():
	var item_cells = $Items.get_used_cells()
	for cell in item_cells:
		var data = $Items.get_cell_tile_data(cell)
		var type = data.get_custom_data("type")
		var item = item_scene.instantiate()
		add_child(item)
		item.init(type, $Items.map_to_local(cell))
		item.picked_up.connect(self._on_item_picked_up)

func _on_item_picked_up():
	score += 1


func _on_limbo_hsm_active_state_changed(current, _previous):
	if is_instance_valid(state_label):
		state_label.text = current.name
