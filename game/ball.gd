extends CharacterBody2D
var speed = 500
@onready var ray_cast_2d : RayCast2D = $RayCast2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var game = $".."
signal score1
signal score2
func _physics_process(delta):
	if global_position.x < 0:
		emit_signal("score2")
	elif global_position.x > game.game_width:
		emit_signal("score1")
	ray_cast_2d.target_position = velocity.normalized() * ((collision_shape_2d.shape.get_rect().size.x/2)+2)
	if ray_cast_2d.is_colliding():
		speed += 5
		if ray_cast_2d.get_collider() is Bat:
			ray_cast_2d.get_collider().shrink()
		var surface_norm = ray_cast_2d.get_collision_normal()
		velocity = -velocity.reflect(surface_norm)
		velocity = velocity.normalized()*speed
	move_and_slide()
