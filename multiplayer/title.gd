extends Control


func _on_multiplayer_pressed():
	get_tree().change_scene_to_file("res://multiplayer/multiplayer.tscn")


func _on_singleplayer_pressed():
	get_tree().change_scene_to_file("res://game/game.tscn")
