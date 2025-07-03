class_name state_machine extends Node

@export var enemy : CharacterBody3D

@export var current_state : state

var states : Array[state]

# for each state under the state machine append to a list and asign it to the enemy
func _ready():
	for child in get_children():
		if(child is state):
			states.append(child)
			
			# Set the states up with what they need to function
			child.enemy = enemy

			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

# when the state's scene is the current one then it will only play the physics process and similiar function on that single state
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	#print(current_state)	
	current_state.physics_update(delta)
	
func _process(delta):
	
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	#print(current_state)	
	current_state.update(delta)

func _unhandled_input(_input: InputEvent) -> void:
	current_state.handle_input(_input)

func switch_states(new_state : state):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()
