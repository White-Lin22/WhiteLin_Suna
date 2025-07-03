extends Area3D

var player : CharacterBody3D 

# resets scene when the player entered the collision 
func _on_body_entered(body: Node3D) -> void:
	player = get_tree().get_first_node_in_group("Player")
	if body == player:
		get_tree().reload_current_scene()
	
	
