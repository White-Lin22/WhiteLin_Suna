extends Node3D

@export var target : CharacterBody3D
@export var enemy : CharacterBody3D
# calls the enemy which is in its own group, sets the target position as the player's position
func _process(delta: float) -> void:
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
