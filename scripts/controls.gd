extends Label3D


@export var player : CharacterBody3D


func _on_timer_2_timeout() -> void:
	look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	rotate_y(deg_to_rad(180))
