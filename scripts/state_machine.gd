class_name state_machine extends Node

@export var enemy : CharacterBody3D

@export var current_state : state

var states : Array[state]

func _ready():
	for child in get_children():
		if(child is state):
			states.append(child)
			
			# Set the states up with what they need to function
			child.enemy = enemy

			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _physics_process(delta):
	print(current_state)
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
		
	current_state.physics_update(delta)

func check_if_can_move():
	return current_state.can_move


func switch_states(new_state : state):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()
