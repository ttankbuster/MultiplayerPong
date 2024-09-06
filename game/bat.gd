extends Area2D
class_name Bat
@onready var collision_shape_2d = $CollisionShape2D
@onready var polygon = $polygon
var game
var net_id = ""
const vertical_margin = 40
var x_set : float
var width
var height
func _ready():
	game = get_parent()
	x_set = global_position.x
	set_shape()
func set_shape():
	var rect = collision_shape_2d.shape.get_rect()
	width = rect.size.x
	height = rect.size.y
	var points = [
	Vector2(rect.position.x, rect.position.y),
	Vector2(rect.position.x+width, rect.position.y),
	Vector2(rect.position.x+width, rect.position.y+height),
	Vector2(rect.position.x, rect.position.y+height)
	]
	polygon.set_polygon(points)
func _process(delta):
	if net_id == "":
		var new_pos = get_global_mouse_position()
		new_pos.x = x_set
		new_pos.y = clamp(
			new_pos.y,
			vertical_margin+(height/2),
			game.game_height-vertical_margin-(height/2)
		)
		global_position = new_pos
func shrink():
	var shape = collision_shape_2d.shape
	shape.size.y *= 0.95
	shape.size.y = max(shape.size.y,10)
	collision_shape_2d.set_shape(shape)
	set_shape()
