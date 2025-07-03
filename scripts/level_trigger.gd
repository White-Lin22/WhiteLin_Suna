extends Area3D

@export var player: CharacterBody3D

# loads the next scene when the player fills the condition
func _on_body_entered(body: Node3D) -> void:
	print(player)
	print(player.win_con)
	if body == player and player.win_con == true:
		get_tree().change_scene_to_file("res://scenes/level_1_2.tscn")
		
	
