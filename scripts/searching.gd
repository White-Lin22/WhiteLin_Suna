extends state


class_name searching

@export var idle_state : state
@export var patrol_state : state
@export var chasing_state : state

@export var state_label : Label3D
@export var sight_raycast : RayCast3D
@export var sight_area : Area3D


var player : CharacterBody3D
var start_rotating = false
var rotation_amount = 0.0
var rotation_speed = 180

var eye_closed
var eye_open
var orange_eye_open

func on_enter():
	player = get_tree().get_first_node_in_group("Player")
	eye_open = player.get_node("CameraHolder/Camera3D/interact/Control/eye_open")
	eye_closed = player.get_node("CameraHolder/Camera3D/interact/Control/eye_closed")
	orange_eye_open = player.get_node("CameraHolder/Camera3D/interact/Control/orang_eye_open")
	print("entered searching")
	state_label.text ="[seaching]"

	
func physics_update(delta):
	spinning(delta)
	
			
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
		go_to_patrol_state()
		
		
func go_to_chase_state():
	eye_closed.visible = false
	eye_open.visible = true
	orange_eye_open.visible = false
	next_state = chasing_state
	
func go_to_idle_state():
	next_state = idle_state
	
func go_to_patrol_state():
	eye_open.visible = false
	eye_closed.visible = true
	orange_eye_open.visible = false
	next_state = patrol_state


func _on_sight_timer_timeout() -> void:
	var overlaps = sight_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap == player:
				sight_raycast.look_at(player.global_transform.origin, Vector3.UP)
				sight_raycast.force_raycast_update()
				if sight_raycast.is_colliding():
					var collider = sight_raycast.get_collider()
					if collider == player:
						go_to_chase_state()
					else:
						print("player not detected")
