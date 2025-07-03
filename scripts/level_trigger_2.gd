extends Area3D

@export var player: CharacterBody3D

func _on_body_entered(body: Node3D) -> void:
	print(player)
	print(player.win_con)
	if body == player and player.win_con == true:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
