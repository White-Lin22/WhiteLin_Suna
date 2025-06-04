extends state

class_name idle

var player : CharacterBody3D

@export var search_state : state
@export var state_label : Label3D

func on_enter()-> void:
	print("aedthaejeatjeatjeaJ")
	player = get_tree().get_first_node_in_group("Player")
	state_label.text ="[idle]"
	#print("entered idle state")

func update(delta)-> void:
	player = get_tree().get_first_node_in_group("Player")
	state_label.text ="[idle]"
	#print("entered idle state")
	
func _physics_process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("Player")
	state_label.text ="[idle]"
	

func handle_input(_input: InputEvent)-> void:
	pass 
	
func go_to_search_state():
	next_state = search_state


func _on_sight_area_body_entered(body: Node3D) -> void:
	print(player)
	if body == player:
		print("player entered")
		go_to_search_state()
