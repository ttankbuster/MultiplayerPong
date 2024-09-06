extends Node2D
const game_width = 1152.0
const game_height = 648.0
var p1_score = 0
var p2_score = 0
var throw_dir = 1
@onready var ball = $ball
@onready var ui = $ui

func throw_ball():
	ui.set_scores(p1_score,p2_score)
	throw_dir *= -1
	ball.global_position = Vector2(576,40)
	ball.velocity = Vector2(0.9*throw_dir,0.5).normalized()*ball.speed
func _ready():
	ball.connect("score1",score1)
	ball.connect("score2",score2)
	throw_ball()
func score1():
	p1_score += 1
	throw_ball()
func score2():
	p2_score += 1
	throw_ball()
