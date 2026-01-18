extends Area2D

signal picked_up

var textures = {
	"cherry": "res://assets/sprites/cherry.png",
	"gem": "res://assets/sprites/gem.png"
}

func init(type: String, _position: Vector2) -> void:
	$Sprite2D.texture = load(textures[type])
	position = _position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_item_body_entered(_body: Node2D):
	picked_up.emit()
	queue_free()
