extends state


class_name searching

@export var chasing_state : state
@export var state_label : Label3D
@export var sight_raycast : RayCast3D
@export var idle_state : state


var player : CharacterBody3D
var start_rotating = false
var rotation_amount = 0.0
var rotation_speed = 180

func on_enter():
	player = get_tree().get_first_node_in_group("Player")
	print("entered searching")
	state_label.text ="[seaching]"

	
func physics_update(delta):
	spinning(delta)
	sight()
	
func sight():
	
	# counts the amount of rotation for restricting the amount of spins
	if sight_raycast.is_colliding():
#		# gets the collider of the raycast
		var collider = sight_raycast.get_collider()
#		# if the collider detects the player than it changes into the chase state, if not prints the collider
		if collider == player:
			go_to_chase_state()
			
# spins enemy twice	
func spinning(delta):
	if rotation_amount < 720:
		var step = rotation_speed*delta
		enemy.rotate_y(deg_to_rad(step))
		rotation_amount += step
		print(rotation_amount)
	else:
		# resets the both the counter for rotation and the boolean for starting rotations
		rotation_amount = 0
		go_to_idle_state()
		
		
		
#func handle_input(_input: InputEvent):
#	if(_input.is_action_pressed("chasing")):
#		print("inputing chasing")
#		go_to_chase_state()
		
func go_to_chase_state():
	next_state = chasing_state
	
func go_to_idle_state():
	next_state = idle_state
