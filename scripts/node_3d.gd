extends Node3D

@onready var target = $Player

# calls the enemy which is in its own group, sets the target position as the player's position
func _process(delta: float) -> void:
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
