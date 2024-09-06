extends CanvasLayer

@onready var menu = $menu
@onready var player_1_score = $scores/Player1Score
@onready var player_2_score = $scores/Player2Score

func _input(event):
	if event.is_action_pressed("menu"):
		menu.visible = not menu.visible
	if menu.visible:
		pass
func set_scores(p1,p2):
	player_1_score.text = "Player1 :   [b]"+str(p1)+"[/b]"
	player_2_score.text = "Player2 :   [b]"+str(p2)+"[/b]"
