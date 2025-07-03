extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
