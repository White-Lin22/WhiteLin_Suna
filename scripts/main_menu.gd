extends Control

# unlocks the mouse so player can click
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# fullscreen button
func _input(event):
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)

# start button loads tutorial scene
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")

# quit button quits scene
func _on_quit_pressed() -> void:
	get_tree().quit()
