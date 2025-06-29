extends state

class_name idle

var player : CharacterBody3D


@export var search_state : state
@export var state_label : Label3D
@export var hearing_label : Label3D
@export var sight_timer : Timer
@export var sight_raycast : RayCast3D

var player_got = false
var hearing_status = 0
var hearing_on = false

func on_enter()-> void:
	print("entered idle")
	state_label.text ="[idle]"
	player = get_tree().get_first_node_in_group("Player")
	#print("entered idle state")

func physics_update(delta):
	while player_got == false:
		player = get_tree().get_first_node_in_group("Player")
		player_got = true
		print("player got: ", player_got)

func update(delta): 
	hearing_meter()
	if hearing_status == 500:
		go_to_search_state()
	hearing_label.text = "hearing: " + str(hearing_status)

func handle_input(_input: InputEvent)-> void:
	pass 
	
func go_to_search_state():
	next_state = search_state

#func _on_sight_area_body_entered(body: Node3D) -> void:
#	if body == player:
#		print("player entered")
#		go_to_search_state()
#		hearing_status = 0
		
func hearing_meter():
	if hearing_on == true:
		hearing_status += 1
		await get_tree().create_timer(1).timeout
		print(hearing_status)
	else:
		if hearing_status > 0:
			hearing_status -= 1
			await get_tree().create_timer(1).timeout
			print(hearing_status)

		
func _on_hearing_area_entered(area: Area3D) -> void:
	hearing_on = true


func _on_hearing_area_exited(area: Area3D) -> void:
	hearing_on = false



				
				
