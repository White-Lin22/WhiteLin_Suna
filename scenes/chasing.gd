extends state


class_name chasing

@export var idle_state : state

func on_enter():
	print("entered chasing")

func handle_input(_input: InputEvent):
	if(_input.is_action_pressed("idle_test")):
		go_to_idle_state()
		
func go_to_idle_state():
	next_state = idle_state
	
