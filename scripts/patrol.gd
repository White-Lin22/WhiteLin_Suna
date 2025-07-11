extends state

class_name patrol

var player : CharacterBody3D
var speed = 100

@export var search_state : state
@export var chasing_state : state

@export var state_label : Label3D
@export var hearing_label : Label3D
@export var nav_agent : NavigationAgent3D
@export var sight_area : Area3D
@export var sight_raycast : RayCast3D
@export var hearing_bar : ProgressBar

var player_got = false
var hearing_status = 0
var hearing_on = false

var eye_open
var eye_closed
var orange_eye_open


func on_enter()-> void:
	print("entered patrol")
	player = get_tree().get_first_node_in_group("Player")
	state_label.text ="[patrol]"
	#print("entered idle state")

func update(delta): 	
	while player_got == false:
		player = get_tree().get_first_node_in_group("Player")
		player_got = true
		print("player got: ", player_got)
		
	eye_open = player.get_node("CameraHolder/Camera3D/interact/Control/eye_open")
	eye_closed = player.get_node("CameraHolder/Camera3D/interact/Control/eye_closed")
	orange_eye_open = player.get_node("CameraHolder/Camera3D/interact/Control/orang_eye_open")
	
	# always records the amount of time spent within the hearing area 3d then leads to the search state
	hearing_meter()
	if hearing_status >= 100:
		go_to_search_state()


	hearing_label.text = "hearing: " + str(hearing_status)
	hearing_bar.value = hearing_status
		
func physics_update(delta):
	patrolling(delta)
	
	
func go_to_search_state():
	eye_closed.visible = false
	eye_open.visible = false
	orange_eye_open.visible = true
	next_state = search_state

func go_to_chase_state():
	eye_closed.visible = false
	eye_open.visible = true
	orange_eye_open.visible = false
	next_state = chasing_state

# when the player's hearing area3d overlaps with the enemys the bar goes up when inside and goes down when not
func hearing_meter():
	if hearing_on == true:
		hearing_status += 1
		await get_tree().create_timer(1).timeout

	else:
		if hearing_status > 0:
			hearing_status -= 1
			await get_tree().create_timer(1).timeout
	
# sets the target position to the appended list of markers 
func patrolling(delta):
	var dir
	nav_agent.target_position =  enemy.all_points[enemy.next_point]
	dir = nav_agent.get_next_path_position() - enemy.global_position
	dir = dir.normalized()
	
	enemy.velocity = enemy.velocity.lerp(dir * speed * delta,1.0)
	
	dir.y = 0
	
	enemy.look_at(enemy.global_transform.origin + dir)

	
	enemy.move_and_slide()

#func _on_sight_area_body_entered(body: Node3D) -> void:
#	print("serthseth")
#	if body == player:
#		print("player entered")
#		go_to_search_state()
#		hearing_status = 0


func _on_hearing_area_entered(area: Area3D) -> void:
	hearing_on = true


func _on_hearing_area_exited(area: Area3D) -> void:
	hearing_on = false


func _on_navigation_agent_3d_target_reached() -> void:
	enemy.next_point += 1
	
	if enemy.next_point >= enemy.all_points.size():
		enemy.next_point = enemy.all_points[-1]
		enemy.next_point = 0

# when the timer goes to 0 it will record if the player is within the area3d, project a raycast and if there's nothing between it and the player then = chase
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
						
