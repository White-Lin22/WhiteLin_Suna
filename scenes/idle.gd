extends state

class_name idle

@export var search_state : state

func on_enter():
	print("entered idle")

func handle_input(_input: InputEvent):
	if(_input.is_action_pressed("searching")):
		print("pressed h")
		go_to_search_state()
		
func go_to_search_state():
	next_state = search_state

func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("searching")):
		print("pressed h")
		go_to_search_state()
