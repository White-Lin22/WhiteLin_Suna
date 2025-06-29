extends state

class_name patrol

var player : CharacterBody3D
var speed = 200

@export var search_state : state
@export var chasing_state : state

@export var state_label : Label3D
@export var hearing_label : Label3D
@export var nav_agent : NavigationAgent3D
@export var sight_area : Area3D
@export var sight_timer : Timer
@export var sight_raycast : RayCast3D

var player_got = false
var hearing_status = 0
var hearing_on = false


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
	hearing_meter()
	if hearing_status >= 500:
		go_to_search_state()

	hearing_label.text = "hearing: " + str(hearing_status)
		
func physics_update(delta):
	patrolling(delta)
	
	
func go_to_search_state():
	next_state = search_state

func go_to_chasing_state():
	next_state = chasing_state

func hearing_meter():
	if hearing_on == true:
		hearing_status += 1
		await get_tree().create_timer(1).timeout

	else:
		if hearing_status > 0:
			hearing_status -= 1
			await get_tree().create_timer(1).timeout
	

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
						go_to_chasing_state()
					else:
						print("player not detected kdfkdfkdf")
				
