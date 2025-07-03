extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(event.relative.y * -0.08))
		rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
