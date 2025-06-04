extends state


class_name searching

@export var chasing_state : state

func on_enter():
	print("entered searching")

func handle_input(_input: InputEvent):
	if(Input.is_action_pressed("chasing")):
		go_to_chase_state()
		
func go_to_chase_state():
	next_state = chasing_state
	
