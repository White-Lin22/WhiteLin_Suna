extends state


class_name chasing

@export var idle_state : state
@export var searching_state : state
@export var state_label : Label3D
@export var nav_agent : NavigationAgent3D
@export var sight_raycast : RayCast3D
@export var sight_area : Area3D

var speed = 4
var player : CharacterBody3D

func on_enter():
	print(enemy)
	player = get_tree().get_first_node_in_group("Player")
	print("entered chasing")
	state_label.text ="[chasing]"
	
func physics_update(delta):
		chase()

func chase():
	# variables that the enemy needs to interact with the navigtion region
	# counts the amount of rotation for restricting the amount of spins
	var overlaps = sight_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap == player:
				sight_raycast.look_at(player.global_transform.origin, Vector3.UP)
				sight_raycast.force_raycast_update()
				if sight_raycast.is_colliding():
					var collider = sight_raycast.get_collider()
					if collider == player:
						# if the collider detects the player than it changes into the chase state, if not prints the collider
						var next_location = nav_agent.get_next_path_position()
						var current_location = enemy.global_transform.origin
						var new_velocity = (next_location - current_location).normalized() * speed

						
						# set the velocity towards the player
						enemy.velocity = enemy.velocity.move_toward(new_velocity, 0.25)
						# looks at the player
						enemy.look_at(player.global_transform.origin, Vector3.UP)
						#print(current_location)
						#print(next_location)
						enemy.move_and_slide()
					else:
						go_to_searching_state()
#		# gets the collider of the raycast
				else:
					go_to_searching_state()
			else:
				go_to_searching_state()
	else:
		go_to_searching_state()




#func handle_input(_input: InputEvent):
#	if(_input.is_action_pressed("idle_test")):
#		go_to_idle_state()
		
func go_to_idle_state():
	next_state = idle_state
	
func go_to_searching_state():
	next_state = searching_state
