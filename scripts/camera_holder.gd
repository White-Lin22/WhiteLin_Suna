extends Node3D


# sets the mouse look and locks the camera to the poles of the character
func _input(event):
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(event.relative.y * -0.08))
		rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))
